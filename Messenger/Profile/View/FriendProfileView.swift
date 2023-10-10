//
//  FriendProfileView.swift
//  Messenger
//
//  Created by Furkan Güryel on 17.09.2023.
//

import SwiftUI
import Kingfisher

struct FriendProfileView: View {
    let user : User?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            VStack{
                Button("Back"){
                    dismiss()
                }
                .foregroundColor(.green)
                .padding(.trailing,300)
                if user?.profileImageLink != nil{
                    KFImage(URL(string: user?.profileImageLink ?? ""))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFill()
                        .clipShape(Circle())
                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color(.systemGreen))
                        .scaledToFill()
                        .clipShape(Circle())
                }
                Text(user?.fullname ?? "")
                    .fontWeight(.bold)
                    .padding(.top)
                    .navigationBarBackButtonHidden(true)
            }
            List{
                Section{
                    Button {
                        UIPasteboard.general.string = user?.email
                    } label: {
                        HStack{
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.green)
                            Text("E-Mail: ")
                                .foregroundColor(.black)
                            Text(user?.email ?? "")
                        }
                    }
                    
                }
            }
        }
    }
}
/*
 struct FriendProfileView_Previews: PreviewProvider {
 static var previews: some View {
 FriendProfileView(user: User.fakeUser)
 }
 }
 */
