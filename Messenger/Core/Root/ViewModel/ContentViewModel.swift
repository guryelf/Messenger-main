//
//  ContentViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 19.09.2023.
//

import Foundation
import Firebase
import Combine
import SwiftUI

class ContentViewModel : ObservableObject{
    @Published var userSession : FirebaseAuth.User?
    private var viewModel = NewMessageViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    init() {
        setup()
    }
    private func setup(){
        AuthService.shared.$userSession.sink { [weak self] sessionFromAuth in
            self?.userSession = sessionFromAuth
        }.store(in: &cancellables)
    }
}
