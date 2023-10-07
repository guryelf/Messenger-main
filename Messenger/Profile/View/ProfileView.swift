//
//  ProfileView.swift
//  Messenger
//
//  Created by Furkan Güryel on 17.09.2023.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewmodel = ProfileViewModel()
    @StateObject var inboxModel = InboxViewModel()
    var user : User?{
        return inboxModel.currentUser
    }
    var body: some View {
        VStack{
            VStack{
                Button("Back"){
                    dismiss()
                }
                .padding(.trailing,300)
                .foregroundColor(.green)
                VStack(alignment: .center,spacing: 15){
                    PhotosPicker(selection: $viewmodel.selectedPhoto) {
                        if let image = viewmodel.profilePhoto{
                            VStack(spacing:15){
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100,height: 100)
                                    .clipShape(Circle())
                            }
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
                    Text(user?.fullname ?? "Kullanıcı İsmi")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(width: 200)
                        .foregroundColor(.black)
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: 200)
            }
            List{
                Section{
                    ForEach(ProfileOptionsViewModel.allCases){options in
                        HStack{
                            Image(systemName: options.Image)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(options.ImageColor)
                            Text(options.title)
                                .padding(.trailing)
                        }
                    }
                }
                Section{
                    Button("Log out"){
                        AuthService.shared.signout()
                    }
                    .foregroundColor(.red)
                    Button("Delete Account"){
                        
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
