//
//  NotificationModel.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/06/06.
//

import Foundation

struct LocalNotification {
    var id: String
    var title: String
    var body: String
}

enum LocalNotificationDurationType {
    case days
    case hours
    case minutes
    case seconds
}
