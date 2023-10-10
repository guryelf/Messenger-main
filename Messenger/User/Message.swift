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
    
    var user: User?
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }
    
    var chooseId : String{
        return senderId == Auth.auth().currentUser?.uid ? receiverId : senderId
    }
    
    var isThisCurrentUser : Bool{
        return senderId == Auth.auth().currentUser?.uid
    }
    var timeStampString : String{
        return timeStamp.dateValue().timeStampString()
    }
}

