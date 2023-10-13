//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 20.09.2023.
//

import Foundation

class NewMessageViewModel: ObservableObject{
    @Published var users = [User]()
    @Published var query = ""
    init() {
        Task{try await fetchUsers()}
        filterUsers(query: query, users: &users)
    }
    @MainActor
    func fetchUsers() async throws{
        self.users = try await UserService().decodeUsers()
    }
    
    func filterUsers(query: String,users:inout[User]){
        if query == ""{
            users.sort { user1, user2 in
                let user1fn = user2.fullname.first ?? "a"
                let user2fn = user2.fullname.first ?? "a"
                
                return user1fn > user2fn
            }
        }else{
            users = users.filter { $0.fullname.lowercased().contains(query.lowercased()) }}
    }
}
