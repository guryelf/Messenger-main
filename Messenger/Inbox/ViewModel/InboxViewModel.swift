//
//  InboxViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 20.09.2023.
//

import Foundation
import Firebase
import Combine
@MainActor
class InboxViewModel: ObservableObject{
    @Published var changes = [DocumentChange]()
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    init() {
        setup()
        self.gettingRecentMessages()
    }
    private var cancellables = Set<AnyCancellable>()
    
    private func setup() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        self.$changes.sink { [weak self] changes in
            self?.loadMessages(changes: changes)
        }.store(in: &cancellables)
    }
    private func gettingRecentMessages(){
        recentMessages.removeAll()
        guard let userId = Auth.auth().currentUser?.uid else {return }
        
        let query = Firestore.firestore().collection("messages")
            .document(userId)
            .collection("recent-messages")
            .order(by:"timeStamp",descending: false)
        
        query.addSnapshotListener { snapshot, error in
            guard let documentChanges =
                    snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified}) else {return }
            self.changes.append(contentsOf: documentChanges)
        }
    }
    private func loadMessages(changes: [DocumentChange]){
        let messages = changes.compactMap { try? $0.document.data(as: Message.self) }
        var unique = messages.filter { message in
            let isUnique = !messages.contains { item in
                item.timeStamp != message.timeStamp && message.id == item.id
            }
            return isUnique
        }
        for i in 0..<unique.count{
            UserService.fetchUser(useruid: unique[i].chooseId) { user in
                unique[i].user = user
            }
            self.recentMessages.append(unique[i])
        }
    }
    func deleteMessages(chatterId : String)async throws{
        guard let userId = Auth.auth().currentUser?.uid else{ return }
        do{
            try await Firestore.firestore().collection("messages").document(userId).collection("recent-messages").document(chatterId).delete()
        }catch{
            print("DEBUG: ERROR OCCURED WHILE DELETING MESSAGES.... \(error.localizedDescription)")
        }
    }
}
