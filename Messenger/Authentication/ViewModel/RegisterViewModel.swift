//
//  RegisterViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import Foundation

protocol AuthFormValidation {
    var isFormValid : Bool {get}
    var isPasswordValid : Bool {get}
    var isPasswordEqual : Bool {get}
}


class RegisterViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    func createUser() async throws{
        try await AuthService.shared.register(email: email, password: password, fullname: fullname)
    }
}
