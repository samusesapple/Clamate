//
//  ViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit

final class ViewController: UIViewController, UITabBarDelegate, UINavigationControllerDelegate {
    private let colorHelper = ColorHelper()
    private var mainView = MainView()
    private let coreDataManager = CoreDataManager.shared
    private let weatherDataManager = WeatherDataManager.shared
    
    override func loadView() {
        view = mainView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUserData()
        setUpTodaySchedule()
    }
    
    
    // MARK: - set UI with Data
    private func setUpUserData() {
        if coreDataManager.getUserInfoFromCoreData().count > 0 {
            mainView.userData = coreDataManager.getUserInfoFromCoreData()[0]
            tabBarController?.tabBar.isHidden = false
            navigationController?.navigationBar.isHidden = false
            setUpWeatherData()
        } else {
            navigationController?.pushViewController(StartViewController(), animated: true)
            tabBarController?.tabBar.isHidden = true
            navigationController?.navigationBar.isHidden = true
        }
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
        
        weatherDataManager.getCityCoord {
            DispatchQueue.main.async { [weak self] in
                let lon = self?.weatherDataManager.lon
                let lat = self?.weatherDataManager.lat
                self?.weatherDataManager.getTodayDust(lat: lat, lon: lon) {
                    DispatchQueue.main.async { [weak self] in
                        self?.mainView.dustResult = self?.weatherDataManager.dustResult
                    }
                }
            }
        }
    }
    
    
}
