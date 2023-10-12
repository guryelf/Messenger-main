//
//  RegisterViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import Foundation

protocol AuthFormValidation {
    var isEmailValid : Bool {get}
    var isPasswordValid : Bool {get}
    var isPasswordEqual : Bool {get}
}


class RegisterViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var alert : ErrorType? = nil
    @Published var hasError = false
    
    func createUser() async throws{
        do{
            try await AuthService.shared.register(email: email, password: password, fullname: fullname)
        }catch{
            self.hasError = true
            self.alert = ErrorType(errorType: AppError.authenticationError(description: error.localizedDescription))
        }
    }
}
