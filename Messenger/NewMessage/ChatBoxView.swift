//
//  ChatBoxView.swift
//  Messenger
//
//  Created by Furkan Güryel on 17.09.2023.
//

import SwiftUI

struct ChatBoxView: View {
    @StateObject var viewModel : ChatBoxViewModel
    @State var friendProfileShowing = false
    @Binding var inboxUser : User?
    @Environment(\.dismiss) var dismiss
    let user : User
    init(user: User,inboxUser:Binding<User?>) {
        self.user = user
        _inboxUser = inboxUser
        self._viewModel = StateObject(wrappedValue: ChatBoxViewModel(user: user))
    }
    var body: some View {
        VStack{
            ScrollView{
            }
            .frame(maxHeight: 0)
            .toolbar{
                ToolbarItem(placement:.topBarLeading) {
                    Button("Back"){
                        inboxUser = nil
                        dismiss()
                    }
                    .foregroundStyle(Color(.systemGreen))
                }
            }
            NavigationStack{
                VStack(alignment: .leading) {
                    Button{
                        friendProfileShowing.toggle()
                    }label:{
                        VStack{
                            Image(user.profileImageLink ?? "person.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                            Text(user.fullname)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .font(.subheadline)
                        }
                    }
                }
                Divider()
            }
            .navigationBarBackButtonHidden()
            .fullScreenCover(isPresented: $friendProfileShowing, content: {
                FriendProfileView(user: user)
            })
            ScrollViewReader(content: { proxy in
                ScrollView{
                    ForEach(viewModel.messages){message in
                        MessageBoxView(message: message)
                    }
                }
                .onChange(of: viewModel.messages.last?.id) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .bottom)
                    }
                }
                
                .listStyle(.plain)
                .listRowSeparator(.hidden)
            })
            .scrollDismissesKeyboard(.interactively)
            Spacer()
            ZStack(alignment: .trailing){
                TextField("Message Here", text: $viewModel.messageText,axis: .vertical)
                    .padding(10)
                    .padding(.trailing,80)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(20)
                Button {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width:40,height: 40)
                }
                .padding(.leading,-2.5)
            }
            
        }
    }
}

/*
 struct ChatBoxView_Previews: PreviewProvider {
 static var previews: some View {
 ChatBoxView(user: User.fakeUser, inboxUser: <#Binding<User>#>)
 }
 }
 */
