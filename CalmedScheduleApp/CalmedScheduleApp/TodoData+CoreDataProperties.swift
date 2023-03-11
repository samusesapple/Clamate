//
//  TodoData+CoreDataProperties.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//
//

import Foundation
import CoreData


extension TodoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoData> {
        return NSFetchRequest<TodoData>(entityName: "TodoData")
    }

    @NSManaged public var todoDate: Date?
    @NSManaged public var todoTime: Int32
    @NSManaged public var todoTitle: String?
    @NSManaged public var todoDetailText: String?

    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.todoDate else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}


extension TodoData : Identifiable {

}
