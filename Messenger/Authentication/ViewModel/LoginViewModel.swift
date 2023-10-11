//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    func login() async throws{
        try await AuthService.shared.login(email: email, password: password)
    }
    func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
}
