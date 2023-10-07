//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import Foundation

class loginViewModel: ObservableObject{ 
    @Published var email = ""
    @Published var password = ""
    func login() async throws{
        try await AuthService.shared.login(email: email, password: password)
    }
}
