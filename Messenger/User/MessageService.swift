//
//  MessageService.swift
//  Messenger
//
//  Created by Furkan Güryel on 1.10.2023.
//

import Foundation
import Firebase

class MessageService{
    static let messagesRef = Firestore.firestore().collection("messages")
    static func sendMessage(messageText:String , receiver:User){
        guard let userId = Auth.auth().currentUser?.uid else {return }
        guard let receiverId = receiver.uid else {return }
        guard messageText.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else {return }
        
        let receiverUserRef = Firestore.firestore().collection("users").document(receiverId)
        let currentUserRef = messagesRef.document(userId).collection(receiverId).document()
        let receiverRef = messagesRef.document(receiverId).collection(userId).document()
        
        let currentUserRecentRef = messagesRef.document(userId).collection("recent-messages").document(receiverId)
        let recentsReceiver = messagesRef.document(receiverId).collection("recent-messages").document(userId)
        
        let messageId = currentUserRef.documentID
        let message = Message(
            messageId: messageId,
            senderId: userId,
            receiverId: receiverId,
            messageText: messageText,
            timeStamp: Timestamp()
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else {return }
        currentUserRef.setData(messageData)
        receiverRef.setData(messageData)
        
        receiverUserRef.updateData(["hasNewMessage" : "true"])
        recentsReceiver.setData(messageData)
        currentUserRecentRef.setData(messageData)
    }
    static func gettingMessages(chatter:User,completion:@escaping([Message])->Void){
        guard let userUid = Auth.auth().currentUser?.uid else {return }
        let chatterId = chatter.id
        
        let query = messagesRef.document(userUid).collection(chatterId).order(by: "timeStamp",descending: false)
        
        
        query.addSnapshotListener { QuerySnapshot, error in
            guard let changes = QuerySnapshot?.documentChanges.filter({ $0.type == .added }) else {return }
            var messages = changes.compactMap ({ try? $0.document.data(as: Message.self) })
            
            for (index,message) in messages.enumerated() where !message.isThisCurrentUser{
                messages[index].user = chatter
            }
            
            completion(messages)
        }
    }
    
}
