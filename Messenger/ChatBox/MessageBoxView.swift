//
//  MessageBoxView.swift
//  Messenger
//
//  Created by Furkan Güryel on 18.09.2023.
//

import SwiftUI

struct MessageBoxView: View {
    let message : Message
    private var isThisCurrentUser : Bool{
        return message.isThisCurrentUser
    }
    var body: some View {
        HStack{
            if message.isThisCurrentUser{
                Spacer()
                Text(message.messageText)
                    .frame(maxWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.systemGreen))
                    .clipShape(Capsule())
            }
            else{
                Text(message.messageText)
                    .frame(maxWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.systemGray))
                    .clipShape(Capsule())
                    Spacer()
            }
        }
    }
}


