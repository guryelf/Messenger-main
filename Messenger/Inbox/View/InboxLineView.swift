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
            HStack(alignment:.top,spacing:10){
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
                        .fontWeight(.semibold)
                    Text(message.messageText)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .frame(maxWidth: UIScreen.main.bounds.width-100,alignment:.leading)
                }
                .font(.subheadline)
                HStack{
                    Text(message.timeStampString)
                    Image(systemName: "chevron.right")
                        .imageScale(.small)
                }
                .foregroundStyle(Color(.gray))
                .font(.footnote)
            }
        .padding(.horizontal,-10)
        .frame(height: 70)
    }
}


