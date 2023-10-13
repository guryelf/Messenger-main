//
//  NewMessageView.swift
//  Messenger
//
//  Created by Furkan Güryel on 16.09.2023.
//

import SwiftUI
import Kingfisher

struct NewMessageView: View {
    @StateObject var viewModel = NewMessageViewModel()
    @StateObject var profileModel = ProfileViewModel()
    @State var user : User?
    @Environment(\.dismiss) var dismiss
    @State var showingChat = false
    var body: some View {
        ScrollView{
        }
        .frame(maxHeight: 0)
        .toolbar{
            ToolbarItem(placement:.navigationBarLeading) {
                Button("Back"){
                    dismiss()
                }
                .foregroundColor(.green)
            }
        }
        .searchable(text: $viewModel.query)
        List{
            ForEach(viewModel.users){person in
                NavigationStack{
                    Button {
                        user = person
                    } label: {
                        HStack(spacing:20){
                            if person.profileImageLink != nil{
                                KFImage(URL(string: person.profileImageLink ?? ""))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }else{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color(.systemGreen))
                                    .clipShape(Circle())
                            }
                            Text(person.fullname)
                                .font(.subheadline)
                                .foregroundStyle(profileModel.darkModeEnabled ? .white : .black)
                        }
                    }
                    .onChange(of: user, perform: { value in
                        showingChat = value != nil
                    })
                    .navigationDestination(isPresented: $showingChat) {
                        ChatBoxView(user: user ?? User.fakeUser, inboxUser: $user)
                    }
                }
            }
        }
        .navigationTitle("New Message")
        .navigationBarTitleDisplayMode(.large)
    }
}


struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NewMessageView()
        }
    }
}
