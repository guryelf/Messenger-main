//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 20.09.2023.
//

import Foundation

class NewMessageViewModel: ObservableObject{
    @Published var users = [User]()
    init() {
        Task{try await fetchUsers()}
    }
    @MainActor
    func fetchUsers() async throws{
        self.users = try await UserService().decodeUsers()
    }
}
