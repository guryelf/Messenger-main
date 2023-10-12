//
//  ProfileView.swift
//  Messenger
//
//  Created by Furkan Güryel on 17.09.2023.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ProfileViewModel()
    @StateObject var inboxModel = InboxViewModel()
    @State var showAlert = false
    var user : User?{
        return inboxModel.currentUser
    }
    var body: some View {
        NavigationStack{
            VStack(alignment: .center,spacing: 15){
                PhotosPicker(selection: $viewModel.selectedPhoto) {
                    if user?.profileImageLink != nil{
                        KFImage(URL(string: user?.profileImageLink ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    else{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100
                                   , height: 100)
                            .clipShape(Circle())
                            .foregroundColor(.green)
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Back"){
                            dismiss()
                        }
                    }
                }
                .foregroundStyle(Color(.systemGreen))
                Text(user?.fullname ?? "Kullanıcı İsmi")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .frame(width: 200)
                    .foregroundColor(viewModel.darkModeEnabled ? .white : .black)
            }
            .frame(width: UIScreen.main.bounds.width, height: 200)
            List{
                Section{
                    Toggle(isOn: $viewModel.darkModeEnabled) {
                        HStack{
                            Image(systemName: "moon.circle.fill")
                                .foregroundStyle(Color(.systemBlue))
                                .imageScale(.large)
                            Text("Dark Mode")
                        }
                    }
                }
                Section{
                    Button("Log out"){
                        AuthService.shared.signout()
                    }
                    .foregroundColor(.red)
                    Button("Delete Account"){
                        Task{
                            try? await viewModel.deleteAccount()
                        }
                    }
                    .foregroundColor(.red)
                    .alert(isPresented: $viewModel.hasError, error: viewModel.alert?.errorType) {
                    }
                }
            }
            
            .preferredColorScheme(viewModel.darkModeEnabled ? .dark : .light)
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
