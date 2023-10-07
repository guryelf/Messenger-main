//
//  AuthService.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthService {
    @Published var userSession : FirebaseAuth.User?
    static let shared = AuthService()
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session id \(userSession?.uid ?? "")")
        Task{try await UserService.shared.decodeData()}
    }
    @MainActor
    func login(email:String,password:String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            Task{try await UserService.shared.decodeData()}
        } catch{
            print("Debug: \(error.localizedDescription)")
        }
    }
    @MainActor
    func register(email:String,password:String,fullname:String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            Task{try await UserService.shared.decodeData()}
            print("User Created. ID : \(result.user.uid)")
        }catch{
            print("Debug: \(error.localizedDescription)")
        }
    }
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch{
            print("DEBUG:Signout failed.ERROR CODE: \(error.localizedDescription)")
        }
    }
    func uploadUserData(email: String,fullname:String,id:String) async throws{
        let user = User(fullname: fullname, email: email)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
    }
}
