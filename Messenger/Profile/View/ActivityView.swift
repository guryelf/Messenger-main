//
//  Activity.swift
//  Messenger
//
//  Created by Furkan Güryel on 15.09.2023.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var viewModel = NewMessageViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
            }
            .frame(maxHeight: 0)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Back"){
                        dismiss()
                    }
                    .foregroundColor(.green)
                }
            }
            .navigationTitle("Person List")
            .navigationBarTitleDisplayMode(.inline)
            List{
                ForEach(viewModel.users){person in
                    HStack{
                        Image(person.profileImageLink ?? "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        VStack{
                            Text(person.fullname)
                                .fontWeight(.semibold)
                            Divider()
                            Button {
                                UIPasteboard.general.string = person.email
                            } label: {
                                Text(person.email)
                                    .font(.subheadline)
                                    .foregroundStyle(Color(.black))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct Activity_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
