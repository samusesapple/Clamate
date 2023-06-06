//
//  LocalNotificationManager.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/06/06.
//

import Foundation
import UserNotifications
import UIKit

struct LocalNotificationManager {
    static private var notifications = [LocalNotification]()
    
    static private func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if let error = error {
                    print(error)
                    return
                }
                print("성공")
            }
    }
    
    static private func addNotification(title: String, body: String?) -> Void {
        notifications.append(LocalNotification(id: UUID().uuidString,
                                               title: title,
                                               body: body ?? "일정을 확인해주세요."))
    }
    
    static private func scheduleNotifications(_ durationInSeconds: Int, repeats: Bool, userInfo: [AnyHashable: Any]) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound.default
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
            content.userInfo = userInfo
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(durationInSeconds),
                                                            repeats: repeats)
            let request = UNNotificationRequest(identifier: notification.id,
                                                content: content,
                                                trigger: trigger)
            
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            UNUserNotificationCenter.current().add(request)
        }
        notifications.removeAll()
    }
    
    /// 설정된 알림 모두 지우기
    static func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    /// Local Push 알림 생성하기
    static func setNotification(_ duration: Int, repeats: Bool, title: String, body: String?, userInfo: [AnyHashable: Any]) {
        requestPermission()
        addNotification(title: title, body: body)
        scheduleNotifications(duration, repeats: repeats, userInfo: userInfo)
    }
    
    /// Notification Center에 등록된 알림 다 지우고 새로 세팅하기
    static func setPushNotification() {
        cancelNotifications()
        
        let datas = CoreDataManager.shared.getDataToSetOnNotificationCenter()
        
        for data in datas {
            guard let date = data.todoDate,
                  let time = data.todoTime,
                  let title = data.todoTitle,
                  let combinedDate = Date.combine(date: date, time: time) else { return }
            
            LocalNotificationManager.setNotification(Int(combinedDate.timeIntervalSinceNow),
                                                     repeats: false,
                                                     title: title,
                                                     body: nil,
                                                     userInfo: ["aps" : ["user" : "info"]])
            print("알림 세팅 완료: \(title)")
        }
    }
}
