//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift
@MainActor
class ProfileViewModel: ObservableObject{
    
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = false
    
    var user : User?{
        return InboxViewModel().currentUser
    }
    @Published var selectedPhoto: PhotosPickerItem?{
        didSet{ Task{try await loadPhoto()} }
    }
    private var uiImage : UIImage?
    @Published var profilePhoto: Image?
    
    func loadPhoto() async throws {
        guard let item = selectedPhoto else {return}
        guard let imageData = try await item.loadTransferable(type: Data.self ) else {return }
        guard let uiImage = UIImage(data: imageData) else {return }
        self.uiImage = uiImage
        self.profilePhoto = Image(uiImage: uiImage)
        guard let url = try await uploadPhoto(image: uiImage) else {return }
        guard let _ = try? await updateUserPhoto(url: url) else{ return }
        
    }
    private func uploadPhoto(image:UIImage) async throws -> String?{
        let profileImageName = user?.uid ?? ""
        let storageRef = Storage.storage().reference(withPath: profileImageName)
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return "Failed to compress"}
        do{
            let _ = try await storageRef.putDataAsync(imageData)
            let url = try await storageRef.downloadURL().absoluteString
            return url
        }catch{
            print("DEBUG:\(error.localizedDescription)")
        }
        return "nil"
    }
    private func updateUserPhoto(url : String) async throws{
        guard let uiImage = self.uiImage else {return}
        try await UserService.shared.updateUserProfilePhoto(url:url)
    }
    func deleteAccount()async throws{
        guard let uid = user?.uid else {return }
        guard let user = Auth.auth().currentUser else {return}
        do{
            try await user.delete()
            try await Firestore.firestore().collection("users").document(uid).delete()
            ContentViewModel().userSession = nil
            AuthService.shared.userSession = nil
        }catch{
            print("DEBUG: Failed to delete\(error.localizedDescription)")
        }
    }
}
