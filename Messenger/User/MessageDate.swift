//
//  MessageDate.swift
//  Messenger
//
//  Created by Furkan Güryel on 10.10.2023.
//

import Foundation

extension Date {
    private var timeFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dateFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }
    private func timeToString() -> String{
        return timeFormatter.string(from: self)
    }
    private func dateToString() -> String{
        return dateFormatter.string(from: self)
    }
    func timeStampString() -> String{
        if Calendar.current.isDateInToday(self){
            return timeToString()
        }
        else if Calendar.current.isDateInYesterday(self){
            return "Yesterday"
        }
        else{
            return dateToString()
        }
    }
}

