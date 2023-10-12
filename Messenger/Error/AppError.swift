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
    
    var errorDescription: String? {
        switch self {
        case .firestoreError(let description):
            return NSLocalizedString("Firestore Error: " + description,comment: "")
        case .storageError(let description):
            return NSLocalizedString("Storage Error: " + description, comment: "")
        case .authenticationError(let description):
            return NSLocalizedString("Authentication Error: " + description, comment: "")
        case .userServiceError(description: let description):
            return NSLocalizedString("User Service Error: " + description , comment: "")
        }
    }
}

struct ErrorType: Identifiable{
    var id = UUID()
    var errorType : AppError
}

