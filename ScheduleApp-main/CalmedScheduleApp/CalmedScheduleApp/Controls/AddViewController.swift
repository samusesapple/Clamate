//
//  AddViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit

final class AddViewController: UIViewController {
    private let colorHelper = ColorHelper()
    private let dateHelper = DateHelper()
    
    private let addView = AddView()
    var selectedDate: Date? 
    private var selectedTime: Date?
    private var toDoManager = CoreDataManager.shared
    
    override func loadView() {
        view = addView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Add View 나타남")
        tabBarController?.tabBar.isHidden = true
        setUIwithDate()
    }
    
    private func setup() {
        addView.titleTextField.delegate = self
        addView.detailTextView.delegate = self
        setActions()
        setUI()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - set UI
    private func setUI() {
        addView.dateSelectLabel.textColor = colorHelper.cancelBackgroundColor
        addView.dateSelectLabel.text = "날짜를 선택해주세요."
        addView.timeSelectLabel.textColor = colorHelper.cancelBackgroundColor
        addView.timeSelectLabel.text = "시간을 선택해주세요."
    }
    
    private func setUIwithDate() {
        guard let selectedDate = selectedDate else { return }
        addView.dateSelectLabel.textColor = colorHelper.fontColor
        addView.dateSelectLabel.text = dateHelper.shortDateString(date: selectedDate)
    }
    

    // MARK: - set Actions
    private func setActions() {
        addView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        addView.titleTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        addView.dateSelectButton.addTarget(self, action: #selector(dateSelectButtonTapped), for: .touchUpInside)
        addView.timeSelectButton.addTarget(self, action: #selector(timeSelectButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc funcs

    @objc private func dateSelectButtonTapped() {
        let alert = UIAlertController(title: "날짜 설정", message: "추가할 일정의 날짜를 선택해주세요.", preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.locale = Locale(identifier: "ko_KR")
        
        let ok = UIAlertAction(title: "완료", style: .cancel) {  [weak self] action in
            var dateString: String? {
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
                let dateString = myFormatter.string(from: datePicker.date)
                return dateString
            }
            self?.addView.dateSelectLabel.textColor = self?.colorHelper.fontColor
            self?.addView.dateSelectLabel.text = dateString
            self?.selectedDate = datePicker.date
            self?.timeSelectButtonTapped()
        }
        
        alert.addAction(ok)
        
        let vc = AddViewController()
        vc.view = datePicker
        
        alert.setValue(vc, forKey: "contentViewController")
        
        present(alert, animated: true)
    }
    
    @objc private func timeSelectButtonTapped() {
        let alert = UIAlertController(title: "시간 설정", message: "설정할 시간을 선택해주세요.", preferredStyle: .actionSheet)
        let timePicker = UIDatePicker()
        let todayDateString = dateHelper.nowDateString
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ko_KR")
        if addView.dateSelectLabel.text == todayDateString {
            timePicker.minimumDate = .now
        } else if addView.dateSelectLabel.text == "날짜를 선택해주세요." {
            timePicker.minimumDate = .now
        }
        
        let ok = UIAlertAction(title: "완료", style: .cancel) {  [weak self] action in
            let timeString = self?.dateHelper.certainTimeString(time: timePicker.date)
            self?.addView.timeSelectLabel.textColor = self?.colorHelper.fontColor
            self?.addView.timeSelectLabel.text = timeString
            self?.selectedTime = timePicker.date
        }
        
        alert.addAction(ok)
        
        let vc = AddViewController()
        vc.view = timePicker
        
        alert.setValue(vc, forKey: "contentViewController")
        
        present(alert, animated: true)
    }
    
    @objc private func addButtonTapped() {
        addView.addButton.layer.shadowOpacity = 0
        addView.addButton.layer.shadowColor = .none
        addView.addButton.backgroundColor = .lightGray
        
        let titleText = addView.titleTextField.text
        let detailText = addView.detailTextView.text
        let todoDate = self.selectedDate
        let todoTime = self.selectedTime
        guard let text = titleText, !text.isEmpty && text != " ", todoDate != nil, todoTime != nil
        else {
            let failureAlert = UIAlertController(title: "추가 실패", message: "일정의 정보를 기입해주세요.", preferredStyle: .alert)
            
            let failure = UIAlertAction(title: "돌아가기", style: .cancel) {  [weak self] action in
                self?.addView.addButton.backgroundColor = self?.colorHelper.yesButtonColor
                self?.addView.addButton.layer.shadowColor = UIColor.black.cgColor
                self?.addView.addButton.layer.shadowOpacity = 0.5
            }
            failureAlert.addAction(failure)
            present(failureAlert, animated: true, completion: nil)
            
            return
        }
        self.toDoManager.saveToDoData(todoDate: todoDate, todoTime: todoTime, todoTitle: titleText, todoDetail: detailText, todoDone: false, completion: {  [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
    }
        
                                          

    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
        addView.cancelButton.layer.shadowOpacity = 0
        addView.cancelButton.layer.shadowColor = .none
        addView.cancelButton.backgroundColor = .lightGray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("add View 사라질 것")
    }
    
}

extension AddViewController: UITextFieldDelegate {
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        } else {

        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dateSelectButtonTapped()
        return true
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "(선택) 추가 내용을 입력해주세요." {
            textView.text = nil
            textView.textColor = ColorHelper().cancelBackgroundColor
        } else {
            textView.textColor = ColorHelper().fontColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "(선택) 추가 내용을 입력해주세요."
            textView.textColor = ColorHelper().cancelBackgroundColor
        } else {
            textView.textColor = ColorHelper().fontColor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 1 {     
            if textView.text?.first == " " {
                textView.text = ""
                return
            }
        }
        textView.textColor = ColorHelper().fontColor
    }
}


