//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import Foundation
import FirebaseAuth

protocol LoginValidation {
    var isEmailEmpty : Bool {get}
    var isPasswordEmpty : Bool {get}
}

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var alert : ErrorType? = nil
    @Published var hasError = false
    func login() async throws{
        do{
            try await AuthService.shared.login(email: email, password: password)
        }catch{
            self.hasError = true
            alert = ErrorType(errorType: AppError.authenticationError(description: error.localizedDescription))
            print(alert?.errorType)
    }
}
    func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if let error = error{
                self.hasError = true
                self.alert = ErrorType(errorType: AppError.authenticationError(description: error.localizedDescription))
                print(self.alert?.errorType.localizedDescription)
            }
        }
    }
}
