//
//  Extensions.swift
//  Messenger
//
//  Created by Furkan Güryel on 12.10.2023.
//

import Foundation

extension RegisterView: AuthFormValidation{
    var isPasswordEqual: Bool{
        return viewModel.confirmPw == viewModel.password
        && !viewModel.confirmPw.isEmpty
    }
    var isPasswordValid: Bool {
        return (viewModel.password.count > 5)
        && !viewModel.password.isEmpty
    }
    
    var isEmailValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
    }
    
    func setFocus() {
        switch focus{
        case \RegisterViewModel.fullname:
            focus = \RegisterViewModel.email
        case \RegisterViewModel.email:
            focus = \RegisterViewModel.password
        case \RegisterViewModel.password:
            focus = \RegisterViewModel.confirmPw
        default: break
        }
    }
}
