//
//  Sample.swift
//  Messenger
//
//  Created by Furkan Güryel on 17.09.2023.
//

import SwiftUI

struct ChatView: View {
    @State private var userInput = ""

    var body: some View {
                VStack {
                    Text("Kullanıcıdan Metin Girişi")
                        .font(.title)
                        .padding()

                    TextField("Metin girin", text: $userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: 100) // Text input alanının minimum yüksekliğini ayarlayın
                        .padding()

                    Text("Girilen Metin: \(userInput)")
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                }
            }
        }

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
