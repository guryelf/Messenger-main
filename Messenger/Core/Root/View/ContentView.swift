//
//  ContentView.swift
//  Messenger
//
//  Created by Furkan Güryel on 15.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewmodel = ContentViewModel()
    @AppStorage("darkModeEnabled") var darkModeEnabled : Bool = false
    var body: some View {
        Group{
            if viewmodel.userSession != nil{
                InboxView()
                    .preferredColorScheme(darkModeEnabled ? .dark : .light)
            }
            else{
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
