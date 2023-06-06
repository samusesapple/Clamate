//
//  SceneDelegate.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let tabBarVC = UITabBarController()
        
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: OneDayViewController())
        let vc3 = UINavigationController(rootViewController: MonthlyViewController())
        _ = UINavigationController(rootViewController: DetailViewController())

        tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = ColorHelper().backgroundColor
        appearance.configureWithTransparentBackground()
        tabBarVC.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBarVC.tabBar.scrollEdgeAppearance = tabBarVC.tabBar.standardAppearance
        }
        
        tabBarVC.tabBar.barTintColor = ColorHelper().backgroundColor
        tabBarVC.modalPresentationStyle = .automatic
        tabBarVC.tabBar.backgroundColor = ColorHelper().backgroundColor
        tabBarVC.tabBar.barStyle = .default
        tabBarVC.tabBar.layer.cornerRadius = 15
        tabBarVC.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarVC.tabBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        tabBarVC.tabBar.layer.shadowOpacity = 0.3
        tabBarVC.tabBar.layer.shadowRadius = 2.5
        
        tabBarVC.tabBar.unselectedItemTintColor = ColorHelper().buttonColor
        tabBarVC.tabBar.tintColor = ColorHelper().cancelBackgroundColor
  
        guard let items = tabBarVC.tabBar.items else { return }
        let item1 = items[0]
        item1.image = UIImage(systemName: "circle")
        item1.selectedImage = UIImage(systemName: "circle.circle.fill")
        
        let item2 = items[1]
        item2.image = UIImage(systemName: "circle")
        item2.selectedImage = UIImage(systemName: "circle.circle.fill")
        
        let item3 = items[2]
        item3.image = UIImage(systemName: "circle")
        item3.selectedImage = UIImage(systemName: "circle.circle.fill")
        
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        let datas = getDataToSetOnNotificationCenter()
        setPushNotification(with: datas)
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
    /// 1. 완료되지 않은 Todo Data들을 얻기
    func getDataToSetOnNotificationCenter() -> [TodoData] {
        let todoData = CoreDataManager.shared.getToDoListFromCoreData()
        var filteredData: [TodoData] = []
        for data in todoData {
            guard let date = data.todoDate,
                  let time = data.todoTime,
                  let combinedDate = Date.combine(date: date, time: time),
                  combinedDate.timeIntervalSinceNow >= 0,
                  data.done == false else { continue } // 현재 시간 이후의 완료되지 않은 일정의 데이터만 받아오기
            filteredData.append(data)
        }
        print(filteredData.count)
        return filteredData
    }
    
    /// 2.  UserNotificationCenter에 알림 등록하기
    func setPushNotification(with datas: [TodoData]) {
        LocalNotificationManager.cancelNotifications()
        
        for data in datas {
            guard let date = data.todoDate,
                  let time = data.todoTime,
                  let title = data.todoTitle,
                  let combinedDate = Date.combine(date: date, time: time) else { return }
            
            LocalNotificationManager.setNotification(Int(combinedDate.timeIntervalSinceNow),
                                                     repeats: false,
                                                     title: title,
                                                     body: nil,
                                                     userInfo: ["aps" : ["hello" : "world"]])
            print("알림 세팅 완료: \(title)")
        }
    }

}

