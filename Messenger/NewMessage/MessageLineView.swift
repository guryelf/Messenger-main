//
//  MessageLineView.swift
//  Messenger
//
//  Created by Furkan Güryel on 17.09.2023.
//

import SwiftUI

struct MessageLineView: View {
    var body: some View {
            HStack(alignment: .top, spacing: 15){
                Image("person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .trailing){
                    Text("This message contains more than one line")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: UIScreen.main.bounds.width-150,alignment: .leading)
                }
                .padding(.leading)
            }
        }
    }

struct MessageLineView_Previews: PreviewProvider {
    static var previews: some View {
            MessageLineView()

    }
}
