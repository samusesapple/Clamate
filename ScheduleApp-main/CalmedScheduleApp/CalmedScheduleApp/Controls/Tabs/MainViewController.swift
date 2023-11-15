//
//  ViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit
import UserNotifications

final class MainViewController: UIViewController, UITabBarDelegate, UINavigationControllerDelegate {
    private let colorHelper = ColorHelper()
    private var mainView = MainView()
    private let coreDataManager = CoreDataManager.shared
    private let weatherDataManager = WeatherDataManager.shared
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUserData()
        setUpTodaySchedule()
    }
    
    // MARK: - Helpers
    
    private func setEmptyUserDataForNewUser() {
        mainView.userData = nil
    }
    
    private func setUpUserData() {
        guard let userData = coreDataManager.getUserInfoFromCoreData() else {
            setEmptyUserDataForNewUser()
            return
        }
        mainView.userData = userData
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        setUpWeatherData()
    }
    
    
    private func setUpTodaySchedule() {
        mainView.dateLabel.text = DateHelper().nowDateString
        let firstTodo = coreDataManager.getNotFinishedDateToDo(date: Date()).first
        if firstTodo != nil {
            mainView.scheduleLabel.textColor = colorHelper.fontColor
            mainView.scheduleLabel.text = firstTodo?.todoTitle
        } else {
            mainView.scheduleLabel.textColor = colorHelper.cancelBackgroundColor
            mainView.scheduleLabel.text = "남은 일정이 없습니다."
        }
    }
    
    private func setUpWeatherData() {
        weatherDataManager.getTodayTemp {
            DispatchQueue.main.async { [weak self] in
                guard let tempResult = self?.weatherDataManager.tempResult else { return }
                self?.mainView.tempResult = round(tempResult * 10) / 10
            }
        }
        
        weatherDataManager.getTodayDust {
            DispatchQueue.main.async { [weak self] in
                self?.mainView.dustResult = self?.weatherDataManager.dustResult
            }
        }
    }
}


