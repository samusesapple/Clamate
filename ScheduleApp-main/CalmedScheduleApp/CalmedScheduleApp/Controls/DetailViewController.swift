//
//  DetailViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/15.
//

import UIKit

final class DetailViewController: UIViewController {
    let detailView = DetailView()
    private let colorHelper = ColorHelper()
    private let todoManager = CoreDataManager.shared
    private let dateHelper = DateHelper()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.detailTextView.delegate = self
        detailView.titleTextField.delegate = self
        setActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailView.editStatus = false
    }
    
    private func setActions() {
        detailView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        detailView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        
        detailView.dateSelectButton.addTarget(self, action: #selector(dateSelectButtonTapped), for: .touchUpInside)
        detailView.timeSelectButton.addTarget(self, action: #selector(timeSelectButtonTapped), for: .touchUpInside)
    }
    
    @objc private func dateSelectButtonTapped() {
        if detailView.editStatus != true {
            return
        }
        let alert = UIAlertController(title: "날짜 설정", message: "추가할 일정의 날짜를 선택해주세요.", preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.locale = Locale(identifier: "ko_KR")
        
        let ok = UIAlertAction(title: "완료", style: .cancel) {  [weak self] action in
            self?.detailView.dateSelectLabel.textColor = self?.colorHelper.fontColor
            self?.detailView.dateSelectLabel.text = self?.dateHelper.shortDateString(date: datePicker.date)
            self?.detailView.toDoData?.todoDate = datePicker.date
        }
        
        alert.addAction(ok)
        
        let vc = DetailViewController()
        vc.view = datePicker
        
        alert.setValue(vc, forKey: "contentViewController")
        
        present(alert, animated: true)
    }
    
    @objc private func timeSelectButtonTapped() {
        if detailView.editStatus != true {
            return
        }
        let alert = UIAlertController(title: "시간 설정", message: "설정할 시간을 선택해주세요.", preferredStyle: .actionSheet)
        let timePicker = UIDatePicker()
        
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 5
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ko_KR")
        if detailView.dateSelectLabel.text == dateHelper.nowDateString {
            timePicker.minimumDate = .now
        } else if detailView.dateSelectLabel.text == "날짜를 선택해주세요." {
            timePicker.minimumDate = .now
        }
        
        let ok = UIAlertAction(title: "완료", style: .cancel) {  [weak self] action in
            self?.detailView.timeSelectLabel.textColor = self?.colorHelper.fontColor
            self?.detailView.timeSelectLabel.text = self?.dateHelper.certainTimeString(time: timePicker.date)
            self?.detailView.toDoData?.todoTime = timePicker.date
        }
        
        alert.addAction(ok)
        
        let vc = DetailViewController()
        vc.view = timePicker
        
        alert.setValue(vc, forKey: "contentViewController")
        
        present(alert, animated: true)
    }
    
    @objc private func okButtonTapped() {
        detailView.okButton.backgroundColor = .lightGray
        if detailView.okLabel.text == "OK" {
            navigationController?.popViewController(animated: true)
            return
        }
        if detailView.okLabel.text == "SAVE" {
            detailView.toDoData?.todoTitle = detailView.titleTextField.text
            detailView.toDoData?.todoDetailText = detailView.detailTextView.text
            todoManager.updateToDo(newToDoData: detailView.toDoData!) {  [weak self] in
                
                LocalNotificationManager.setPushNotification()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func editButtonTapped() {
        detailView.editButton.backgroundColor = .lightGray
        func setOriginalButtonColor() { self.detailView.editButton.backgroundColor = colorHelper.cancelBackgroundColor }
        let alert = UIAlertController(title: "일정 편집", message: "일정을 편집 하시겠습니까?", preferredStyle: .alert)
        
        if detailView.editLabel.text == "EDIT" {
            print("detailVC - edit button")
            let success = UIAlertAction(title: "예", style: .default) {  [weak self] action in
                self?.detailView.editStatus = true
                self?.detailView.okLabel.text = "SAVE"
                self?.detailView.editLabel.text = "CANCEL"
                setOriginalButtonColor()
            }
            
            let cancel = UIAlertAction(title: "아니오", style: .cancel) {  action in
                setOriginalButtonColor()
            }
            alert.addAction(success)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if detailView.editLabel.text == "CANCEL" {
            alert.title = "편집 취소"
            alert.message = "편집을 취소 하시겠습니까?"
            
            let success = UIAlertAction(title: "예", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
                setOriginalButtonColor()
            }
            
            let cancel = UIAlertAction(title: "아니오", style: .cancel) { action in
                setOriginalButtonColor()
            }
            alert.addAction(success)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if detailView.editStatus == true {
            return true
        }
        return false
    }
    
    private func textFieldEditingChanged(_ textField: UITextField) {
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
        return true
    }
    
}

extension DetailViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if detailView.editStatus == true {
            return true
        }
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "(선택) 추가 내용을 입력해주세요." || textView.text == "작성된 추가 내용이 없습니다." {
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


