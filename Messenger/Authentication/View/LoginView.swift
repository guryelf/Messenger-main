//
//  LoginView.swift
//  Messenger
//
//  Created by Furkan Güryel on 15.09.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State var isForgotPassword = false
    var body: some View {
        NavigationStack{
            VStack{
                Text("Messenger")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .shadow(radius: 5)
                Image("LoginIcon")
                
            }
            VStack(alignment: .center, spacing: 15){
                TextField("E-Mail", text: $viewModel.email)
                    .padding(15)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                    .padding(15)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                Text(isPasswordEmpty ? "This field cannot be empty." : "")
                    .foregroundStyle(Color(.systemRed))
                    .padding(.trailing, 150)
                    .font(.system(size: 15))
                    .frame(height: 0)
            }
            VStack(spacing: 20){
                Button(action:{
                    isForgotPassword.toggle()
                } ,label: {
                    Text("Forgot Password")
                        .padding(.top)
                        .padding(.trailing,25)
                        .foregroundColor(.green)
                        .fontWeight(.semibold)
                })
                .frame(maxWidth: .infinity,alignment: .trailing)
                .sheet(isPresented: $isForgotPassword, content: {
                    ForgotPasswordView()
                        
                })
                Button {
                    Task{ try await viewModel.login() }
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(width: 360,height: 45)
                        .background(Color(uiColor: .systemGreen))
                        .cornerRadius(15)
                }
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.alert?.errorType) {
            }
            Spacer()
            NavigationLink{
                RegisterView()
            }label: {
                HStack(spacing: 5){
                    Text("New Here?")
                        .foregroundColor(.green)
                    Text("Sign Up!")
                        .foregroundColor(.green)
                }
                .font(.headline)
                
            }
            
        }
    }
}

extension LoginView: LoginValidation{
    var isEmailEmpty: Bool {
        return viewModel.email.isEmpty
    }
    
    var isPasswordEmpty: Bool {
        return viewModel.password.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
