//
//  ProfileView-ViewModel.swift
//  Messenger
//
//  Created by Furkan Güryel on 17.09.2023.
//
import SwiftUI
enum ProfileOptionsViewModel : Int, CaseIterable , Identifiable{
    var id: Int{return self.rawValue}
    
    case darkMode
    case notifications
    
    var Image : String{
        switch self{
            
        case .darkMode: return "moon.circle.fill"
        case .notifications: return "bell.circle.fill"
        }
    }
    var ImageColor : Color{
        switch self{
            
        case .darkMode: return .black
        case .notifications: return Color(.systemBlue)
        }
    }
    var title : String{
        switch self{
            
        case .darkMode: return "Dark Mode"
        case .notifications: return "Notifications"
        }
        
    }

}
