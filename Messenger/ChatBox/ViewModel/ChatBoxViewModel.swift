//
//  ChatBoxViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 1.10.2023.
//

import Foundation
import FirebaseFirestoreSwift

class ChatBoxViewModel : ObservableObject{
    @Published var messageText = ""
    @Published var messages  = [Message]()
    let user : User
    init(user:User) {
        self.user = user
        gettingMessages()
    }
    func sendMessage(){
        MessageService.sendMessage(messageText: messageText, receiver: user )
    }
    func gettingMessages(){
        MessageService.gettingMessages(chatter: user) { messages in
            self.messages.append(contentsOf: messages)
        }
    }
    
}
