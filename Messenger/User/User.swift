//
//  User.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import Foundation
import FirebaseFirestoreSwift


struct User: Equatable,Codable,Identifiable,Hashable{
    @DocumentID var uid: String?
    let fullname : String
    var email : String
    var profileImageLink : String?
    var hasNewMessage : Bool?
    
    var id : String{
        return uid ?? NSUUID().uuidString
    }
}
extension User{
    static let fakeUser = User(fullname: "Furkan Güryel", email: "furkangryl917@gmail.com",profileImageLink: "ProfilePhoto")
}
