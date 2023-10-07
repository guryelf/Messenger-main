//
//  InboxView.swift
//  Messenger
//
//  Created by Furkan Güryel on 15.09.2023.
//

import SwiftUI


struct InboxView: View {
    @StateObject var viewModel = InboxViewModel()
    @State var newmessageView = false
    @State var profileView = false
    @State var activityView = false
    @State var user : User?
    @State var showingChat = false
    @State var deleteButton = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
            }
            .frame(maxHeight: 0)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    HStack(spacing:120){
                        Button {
                            activityView.toggle()
                        } label: {
                            Image("Online")
                                .resizable()
                                .frame(width: 50, height: 40)
                        }
                        Button {
                            profileView.toggle()
                        } label: {
                            Image("Account")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        Button {
                            newmessageView.toggle()
                        } label: {
                            Image(systemName: "message")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                        }
                        
                    }
                }
            }
            .fullScreenCover(isPresented: $newmessageView) {
                NavigationStack{
                    NewMessageView()
                }
            }
            .fullScreenCover(isPresented: $profileView) {
                ProfileView()
            }
            .fullScreenCover(isPresented: $activityView) {
                ActivityView()
            }
            List{
                if viewModel.recentMessages.isEmpty{
                    EmptyView()
                }
                else{
                    NavigationStack{
                        ForEach(viewModel.recentMessages){message in
                            InboxLineView(message: message)
                                .onTapGesture {
                                    UserService.fetchUser(useruid: message.chooseId) { user in
                                        self.user = user
                                    }
                                }
                            Divider()
                        }
                    }
                    .onChange(of: user, perform: { value in
                        showingChat = value != nil
                    })
                    .navigationDestination(isPresented: $showingChat) {
                        if let user = user {
                            ChatBoxView(user: user, inboxUser: $user)
                        }
                    }
                }
            }
            
        }
        
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(user: User.fakeUser)
    }
}
