//
//  File.swift
//  Messenger
//
//  Created by Furkan Güryel on 12.10.2023.
//

import Foundation

enum AppError: Error , LocalizedError {
    
    case firestoreError(description: String)
    case storageError(description: String)
    case authenticationError(description: String)
    case userServiceError(description:String)
    
    var localizedDescription: String? {
        switch self {
        case .firestoreError(let description):
            return "Firestore Error: " + description
        case .storageError(let description):
            return "Storage Error: " + description
        case .authenticationError(let description):
            return "Authentication Error: " + description
        case .userServiceError(description: let description):
            return "User Service Error: " + description
        }
    }
}

struct ErrorType: Identifiable{
    var id = UUID()
    var errorType : AppError

}

