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

    private let weatherDataManager = WeatherDataManager.shared
    
    private let cities = ["Seoul", "Incheon", "Seongnam", "Suwon", "Osan", "Ansan", "Seosan",  "Cheonan", "Cheongju", "Chuncheon", "Gangneung", "Sokcho", "Yeosu", "Daejeon", "Daegu", "Busan", "Ulsan", "Jeonju", "Gwangju", "Changwon", "Jeju"]
    
    private let userData = CoreDataManager.shared.getUserInfoFromCoreData() ?? nil
    
    private var selectedCity: String?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setButtonActions()
        
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
        showEditNameAlert()
    }
    
    // TODO: - 위치 버튼에 대한 액션 (위치 새로 받기) 세팅 필요
    @objc private func showSelectCityAlert() {
        let pickerView = UIPickerView()
        let alert = UIAlertController(title: nil, message: "\n\n\n\n\n\n", preferredStyle: .actionSheet)

        pickerView.frame = CGRect(x: 50, y: 0, width: 270, height: 130)
        pickerView.delegate = self
        pickerView.dataSource = self

        alert.addAction(UIAlertAction(title: "확인", style: .cancel) { [weak self] _ in
            guard let userData = self?.userData else {
                CoreDataManager.shared.saveUserData(userName: self?.userData?.userName,
                                                    userCity: self?.selectedCity) {
                    self?.viewWillAppear(false)
                }
                return
            }
            CoreDataManager.shared.updateUserCity(userData.userCity ?? "Seoul",
                                                  into: self?.selectedCity,
                                                 completion: {
                self?.viewWillAppear(false)
            })
        })
        
        alert.view.addSubview(pickerView)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func setEmptyUserDataForNewUser() {
        mainView.userData = nil
    }
    
    private func setUpUserData() {
        guard let userData = userData else {
            setEmptyUserDataForNewUser()
            return
        }
        mainView.userData = userData
    }
    
    private func setButtonActions() {
        mainView.resetWeatherButton.addTarget(self, action: #selector(showSelectCityAlert), for: .touchUpInside)
    }
    
    private func setUpTodaySchedule() {
        mainView.dateLabel.text = DateHelper().nowDateString
        let firstTodo = CoreDataManager.shared.getNotFinishedDateToDo(date: Date()).first
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
        let alert = UIAlertController(title: "닉네임 변경", message: "1~7글자 내로 닉네임을 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = self.mainView.userData?.userName ?? "User"
            textField.delegate = self
            textField.addTarget(self, action: #selector(self.textFieldEditingChanged), for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            let textField = alert.textFields![0]
            
            guard let userName = self?.mainView.userData?.userName else {
                CoreDataManager.shared.saveUserData(userName: textField.text,
                                                   userCity: nil) {
                    self?.viewWillAppear(false)
                }
                return
            }

            CoreDataManager.shared.updateUserName(userName, into: textField.text, completion: {
                self?.viewWillAppear(false)
            })
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - 유저 이름 변경 얼럿창의 UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {        // 첫글자가 공백인지 확인
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 7
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

// MARK: - UIPickerViewDelegate
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCity = cities[row]
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}
