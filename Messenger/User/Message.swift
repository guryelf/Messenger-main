//
//  Message.swift
//  Messenger
//
//  Created by Furkan Güryel on 1.10.2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Message : Identifiable,Codable,Equatable,Hashable {
    
    @DocumentID var messageId: String?
    let senderId: String
    let receiverId: String
    let messageText : String
    let timeStamp : Timestamp
    
    var chatterName : String?
    var chatterProfile: String?
    var user: User?
    
    var id: String{
        return messageId ?? NSUUID().uuidString
    }
    
    var chooseId : String{
        return senderId == Auth.auth().currentUser?.uid ? receiverId : senderId
    }
    
    var isThisCurrentUser : Bool{
        return senderId == Auth.auth().currentUser?.uid
    }
}

extension Message{
    static let message = Message(senderId: NSUUID().uuidString, receiverId:  NSUUID().uuidString, messageText: "sa", timeStamp: Timestamp(),chatterName: "kanka naber",chatterProfile: "LoginIcon")
}
