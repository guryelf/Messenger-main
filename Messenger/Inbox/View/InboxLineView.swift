//
//  InboxLineView.swift
//  Messenger
//
//  Created by Furkan Güryel on 16.09.2023.
//

import SwiftUI
import Kingfisher

struct InboxLineView: View {
    var message : Message
    @StateObject var viewModel = InboxViewModel()
    var body: some View {
        NavigationStack{
            HStack(spacing:10){
                if message.user?.profileImageLink != nil{
                    KFImage(URL(string: message.user?.profileImageLink ?? ""))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFill()
                        .clipShape(Circle())
                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFill()
                        .clipShape(Circle())
                        .foregroundStyle(Color(.systemGreen))
                }
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
                Text(message.timeStampString)
                    .foregroundStyle(Color(.gray))
                    .padding(.leading,60)
                    .font(.footnote)
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundStyle(Color(.gray))
            }
            .frame(minWidth: UIScreen.main.bounds.width-20)
            .padding(.leading)
        }
        .swipeActions(allowsFullSwipe: false){
            Button(action: {
                Task{
                    try await viewModel.deleteMessages(chatterId: message.user?.uid ?? "")
                }
            }, label: {
                Image(systemName: "trash.circle.fill")
                Text("Delete")
            })
            .tint(Color(.systemRed))
        }
    }
}


