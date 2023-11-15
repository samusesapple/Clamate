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
        setUpWeatherData()
        setUpTodaySchedule()
        
        addTapGestureForUserNameEdit()
    }
    
    // MARK: - Actions
    
    private func addTapGestureForUserNameEdit() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeUserChangeName))
        
        mainView.greetingLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func makeUserChangeName(_ sender: UITapGestureRecognizer? = nil) {
        // TODO: - 이름 변경하는 얼럿창 띄워야함
        showEditNameAlert()
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
                guard let tempResult = self?.weatherDataManager.tempResult else {
                    return
                }
                self?.mainView.tempResult = round(tempResult * 10) / 10
            }
        }
        
        weatherDataManager.getTodayDust {
            DispatchQueue.main.async { [weak self] in
                self?.mainView.dustResult = self?.weatherDataManager.dustResult
            }
        }
    }
    
    private func showEditNameAlert() {
        let alert = UIAlertController(title: "닉네임 변경", message: "2~8글자 내로 닉네임을 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = self.mainView.userData?.userName ?? "User"
            textField.delegate = self
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            let textField = alert.textFields![0]
            
            self?.coreDataManager.saveUserData(userName: textField.text,
                                              userCity: nil) {
                self?.viewWillAppear(false)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - 유저 이름 변경 얼럿창의 UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    // TODO: - 첫 입력 Spacebar 막기, 최대 글자 수 8개까지로 제한하기
}
