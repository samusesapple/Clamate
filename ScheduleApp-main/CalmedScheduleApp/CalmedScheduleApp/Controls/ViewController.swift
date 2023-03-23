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
    // 모델(저장 데이터를 관리하는 코어데이터)
    private let coreDataManager = CoreDataManager.shared
    private let dustManager = DustManager.shared
    
    override func loadView() {
        view = mainView
        
    }
    
    
    override func viewDidLoad() {
//        setNaviBar()
//        setUpWeatherData()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUserData()
        setUpTodaySchedule()
    }
    
    // MARK: - set NaviBar
//    private func setNaviBar() {
//        navigationController?.delegate = self
//
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()  // 불투명으로
//        appearance.backgroundColor = colorHelper.backgroundColor
//        appearance.titleTextAttributes = [.foregroundColor: colorHelper.fontColor]
//        appearance.largeTitleTextAttributes = [.foregroundColor: colorHelper.fontColor]
//
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.tintColor = colorHelper.fontColor
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//
//        // Bar 버튼 추가
//        let add = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(addTapped))
//        navigationItem.leftBarButtonItem = add
//    }
    
    // MARK: - set UI with Data
    private func setUpUserData() {
        if coreDataManager.getUserInfoFromCoreData().count > 0 {
            mainView.userData = coreDataManager.getUserInfoFromCoreData()[0]
            tabBarController?.tabBar.isHidden = false
            navigationController?.navigationBar.isHidden = false
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
        dustManager.getTodayDust {
            DispatchQueue.main.async {
                self.mainView.dustResult = self.dustManager.dustResult
                self.loadViewIfNeeded()
            }
        }
    }
    
    // MARK: - add Target
    
    @objc func addTapped() {
        print("Tapped")
    }
    
}

