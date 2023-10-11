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
        gettingRecentMessages()
        setup()
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
        guard let userId = Auth.auth().currentUser?.uid else {return }
        
        let query = Firestore.firestore().collection("messages")
            .document(userId)
            .collection("recent-messages")
            .order(by: "timeStamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            guard let documentChanges =
                    snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified}) else {return }
            for document in documentChanges{
                let documentId = document.document.documentID
                if let index = self.recentMessages.firstIndex(where: { $0.messageId == documentId}){
                    self.changes.remove(at: index)
                }
            }
            self.changes.append(contentsOf: documentChanges.reversed())
        }
    }
    private func loadMessages(changes: [DocumentChange]){
        self.recentMessages = changes.compactMap { try? $0.document.data(as: Message.self) }
        for i in 0..<self.recentMessages.count{
            UserService.fetchUser(useruid: recentMessages[i].chooseId) { user in
                self.recentMessages[i].user = user
            }
        }
    }
    func deleteMessages(chatterId : String)async throws{
        guard let userId = Auth.auth().currentUser?.uid else{ return }
        guard let _ = try? await Firestore.firestore().collection("messages").document(userId).collection("recent-messages").document(chatterId).delete() else {return }
    }
}
