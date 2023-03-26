//
//  TodoData+CoreDataProperties.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/14.
//
//

import Foundation
import CoreData


extension TodoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoData> {
        return NSFetchRequest<TodoData>(entityName: "TodoData")
    }

    @NSManaged public var todoDate: Date?
    @NSManaged public var todoTime: Date?
    @NSManaged public var todoTitle: String?
    @NSManaged public var todoDetailText: String?
    @NSManaged public var done: Bool
    
    var nowDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
        let date = Date()
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    var shortDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
        guard let date = self.todoDate else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    var longDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy년 M월 dd일 (EEE)"
        guard let date = self.todoDate else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    var timeString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "HH:mm a"
        guard let time = self.todoTime else { return "" }
        let savedTimeString = myFormatter.string(from: time)
        return savedTimeString
    }
}


extension TodoData : Identifiable {

}
