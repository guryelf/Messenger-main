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
            TextField("Enter your mail here...", text: $email)
                .frame(width: UIScreen.main.bounds.width-50,height: 40)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            Button(action: {
                Task{
                    viewModel.resetPassword(email: email)
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
            .alert(isPresented: $viewModel.hasError, error: viewModel.alert?.errorType) {
            }
        }
        .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height-200)
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
