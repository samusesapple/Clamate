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

    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.todoDate else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    var timeString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "a h:mm"
        guard let time = self.todoTime else { return "" }
        let savedTimeString = myFormatter.string(from: time)
        return savedTimeString
    }
}


extension TodoData : Identifiable {

}