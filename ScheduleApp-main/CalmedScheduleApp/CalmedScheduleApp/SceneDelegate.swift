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
        let vc4 = UINavigationController(rootViewController: SettingViewController())

        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4], animated: false)
        
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
        let homeTab = items[0]
        homeTab.image = UIImage(systemName: "house")
        homeTab.selectedImage = UIImage(systemName: "house.fill")
        
        let oneDayScheduleTab = items[1]
        oneDayScheduleTab.image = UIImage(systemName: "1.circle")
        oneDayScheduleTab.selectedImage = UIImage(systemName: "1.circle.fill")
        
        let monthlyScheduleTab = items[2]
        monthlyScheduleTab.image = UIImage(systemName: "calendar.circle")
        monthlyScheduleTab.selectedImage = UIImage(systemName: "calendar.circle.fill")
        
        let userSettingTab = items[3]
        userSettingTab.image = UIImage(systemName: "person")
        userSettingTab.selectedImage = UIImage(systemName: "person.fill")
        
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
        LocalNotificationManager.setPushNotification()
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
    

}

