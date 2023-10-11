//
//  ForgotPasswordView.swift
//  Messenger
//
//  Created by Furkan Güryel on 11.10.2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = LoginViewModel()
    @State var email = ""
    var body: some View {
        ScrollView{
        }
        .frame(height: 0)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button("Back"){
                    dismiss()
                }
                .foregroundStyle(Color(.systemGreen))
            }
        }
        Image("Online")
            .resizable()
            .frame(width: 50, height: 50,alignment: .top)
            .aspectRatio(contentMode: .fill)
        VStack{
            VStack{
                Text("Enter the email associated with your account to change your password.")
            }
            .frame(width: UIScreen.main.bounds.width-50)
            .padding(.bottom,20)
            .foregroundStyle(Color(.systemGray))
                TextField("Kayıtlı olduğunuz maili giriniz", text: $email)
                .frame(width: UIScreen.main.bounds.width-50,height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                Button(action: {
                    Task{
                       try await viewModel.resetPassword(email: email)
                    }
                }, label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(width: 150,height: 45)
                        .background(Color(uiColor: .systemGreen))
                        .cornerRadius(15)
                })
        }
        .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height-200)
        
        
    }
}

#Preview {
    ForgotPasswordView()
}
