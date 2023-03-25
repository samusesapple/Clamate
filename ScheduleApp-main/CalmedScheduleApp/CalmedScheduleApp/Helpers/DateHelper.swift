//
//  DateHelper.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/22.
//

import Foundation

public struct DateHelper {
    
    var nowDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
        let date = Date()
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    func veryShortDateString(date: Date?) -> String {
        let myFormatter = DateFormatter()
        myFormatter.locale = Locale(identifier: "en_US")
        myFormatter.dateFormat = "MMMM d"
        guard let date = date else { return "" }
        let dateString = myFormatter.string(from: date)
        return dateString
    }
    
    func shortDateString(date: Date?) -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
        guard let date = date else { return "" }
        let dateString = myFormatter.string(from: date)
        return dateString
    }
    
    func longDateString(date: Date?) -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy년 M월 dd일 (EEE)"
        guard let date = date else { return "" }
        let dateString = myFormatter.string(from: date)
        return dateString
    }
    
    var nowTimeString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "a hh:mm"
        let savedTimeString = myFormatter.string(from: Date())
        return savedTimeString
    }
    
    func certainTimeString(time: Date?) -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "a hh:mm"
        guard let time = time else { return "" }
        let savedTimeString = myFormatter.string(from: time)
        return savedTimeString
    }
    
}
