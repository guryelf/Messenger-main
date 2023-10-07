//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import SwiftUI
import PhotosUI
@MainActor
class ProfileViewModel: ObservableObject{
    var user : User?{
        return InboxViewModel().currentUser
    }
    @Published var selectedPhoto: PhotosPickerItem?{
        didSet{ Task{try await loadPhoto() } }
    }
    @Published var profilePhoto: Image?
    func loadPhoto() async throws {
        guard let item = selectedPhoto else {return}
        guard let imageData = try await item.loadTransferable(type: Data.self ) else {return }
        guard let uiImage = UIImage(data: imageData) else {return }
        self.profilePhoto = Image(uiImage: uiImage)
    }
}
