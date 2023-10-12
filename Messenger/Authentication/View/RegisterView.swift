//
//  RegisterView.swift
//  Messenger
//
//  Created by Furkan Güryel on 15.09.2023.
//

import SwiftUI

struct RegisterView: View {
    @State var text = ""
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack(spacing: 15){
                Image("LoginIcon")
                TextField("Full Name", text: $viewModel.fullname)
                    .padding(15)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                    .autocorrectionDisabled()
                TextField("E-Mail", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(15)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                Text(!isEmailValid ? "Email is not valid" : "")
                    .foregroundStyle(Color(.systemRed))
                    .padding(.trailing, 220)
                    .font(.system(size: 15))
                    .frame(height: 0)
                ZStack(alignment:.trailing){
                    SecureField("Password", text: $viewModel.password)
                        .padding(15)
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(20)
                        .padding(.horizontal,20)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(isPasswordValid ? Color(.systemBlue) : Color(.systemGray2))
                        .imageScale(.large)
                        .padding(.trailing,25)
                }
                ZStack(alignment:.trailing) {
                    VStack{
                        SecureField("Confirm Password", text: $text)
                            .padding(15)
                            .background(Color(uiColor: .systemGray6))
                            .cornerRadius(20)
                            .padding(.horizontal,20)
                    }
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(isPasswordEqual ? Color(.systemBlue) : Color(.systemGray2))
                        .imageScale(.large)
                        .padding(.trailing,25)
                }
            }
            .padding(.bottom,30)
            Button {
                Task{try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 360,height: 45)
                    .background(Color(uiColor: .systemGreen))
                    .cornerRadius(15)
            }
            .disabled(!isEmailValid)
            .opacity(isEmailValid ? 1.0 : 0.5)
            
            Button{
                dismiss()
            }label: {
                HStack(alignment: .bottom, spacing: 5){
                    Text("Already signed in?")
                        .foregroundColor(.green)
                        .padding(.top,150)
                    Text("Sign In")
                        .foregroundColor(.green)
                        .padding(.top,150)
                }
                .font(.headline)
                .padding(.top,50)
            }
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.alert?.errorType){
        }
        
    }
}
extension RegisterView: AuthFormValidation{
    var isPasswordEqual: Bool{
        return text == viewModel.password
        && !text.isEmpty
    }
    var isPasswordValid: Bool {
        return (viewModel.password.count > 5)
        && !viewModel.password.isEmpty
    }
    
    var isEmailValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
    }
}
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
