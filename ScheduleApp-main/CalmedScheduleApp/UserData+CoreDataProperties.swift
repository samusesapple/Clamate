//
//  UserData+CoreDataProperties.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/23.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var userName: String?
    @NSManaged public var userCity: String?

}

extension UserData : Identifiable {

}
