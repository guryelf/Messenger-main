//
//  UserService.swift
//  Messenger
//
//  Created by Furkan Güryel on 19.09.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
@MainActor
class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    func decodeData() async throws{
        guard let uid = Auth.auth().currentUser?.uid else{return }
        let snap = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snap.data(as: User.self)
        self.currentUser = user
        print("DEBUG: Current user id\(currentUser?.uid)")
    }
    func decodeUsers() async throws -> [User] {
        guard let currentid = Auth.auth().currentUser?.uid else{ return []}
        let decodedUsers = try await Firestore.firestore().collection("users").getDocuments()
        let result = decodedUsers.documents.compactMap { try? $0.data(as: User.self)}
        return result.filter({ $0.id != currentid})
    }
    
    static func fetchUser(useruid:String,completion: @escaping  (User) -> Void){
        Firestore.firestore().collection("users").document(useruid).getDocument { snap, error in
            guard let user = try? snap?.data(as: User.self) else {return}
            completion(user)
        }
    }
    func updateUserProfilePhoto(url : String) async throws{
        guard let userUid = currentUser?.uid else {return }
        try? await Firestore.firestore().collection("users").document(userUid).updateData([
            "profileImageLink" : url
        ])
        self.currentUser?.profileImageLink = url
    }
}
