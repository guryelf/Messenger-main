//
//  InboxLineView.swift
//  Messenger
//
//  Created by Furkan Güryel on 16.09.2023.
//

import SwiftUI

struct InboxLineView: View {
    var message : Message
    @StateObject var viewModel = InboxViewModel()
    var body: some View {
        NavigationStack{
            HStack(spacing:10){
                Image(message.user?.profileImageLink ?? "person.circle.fill" )
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment:.leading,spacing:5){
                    Text(message.user?.fullname ?? "" )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.trailing,50)
                    Text(message.messageText)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                Text("Today")
                    .foregroundStyle(Color(.gray))
                    .padding(.leading,60)
                    .font(.footnote)
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundStyle(Color(.gray))
            }
            .frame(minWidth: UIScreen.main.bounds.width-50)
        }
        
    }
}

struct InboxLineView_Previews: PreviewProvider {
    static var previews: some View {
        InboxLineView(message: Message.message)
    }
}

