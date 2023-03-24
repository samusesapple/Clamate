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
    
    // MARK: - set Actions
    private func setActions() {
        detailView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        detailView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        
        detailView.dateSelectButton.addTarget(self, action: #selector(dateSelectButtonTapped), for: .touchUpInside)
        detailView.timeSelectButton.addTarget(self, action: #selector(timeSelectButtonTapped), for: .touchUpInside)
        
    }
    
    // MARK: - addTarget for buttons
    @objc private func dateSelectButtonTapped() {
        if detailView.editStatus != true {
            print("date select 불가")
            return
        }
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
            self?.detailView.dateSelectLabel.textColor = self?.colorHelper.fontColor
            self?.detailView.dateSelectLabel.text = dateString
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
            print("time select 불가")
            return
        }
        let alert = UIAlertController(title: "시간 설정", message: "설정할 시간을 선택해주세요.", preferredStyle: .actionSheet)
        let timePicker = UIDatePicker()
        
        var todayDateString: String? {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
            let dateString = myFormatter.string(from: Date())
            return dateString
        }
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ko_KR")
        if detailView.dateSelectLabel.text == todayDateString {
            timePicker.minimumDate = .now
        } else if detailView.dateSelectLabel.text == "날짜를 선택해주세요." {
            timePicker.minimumDate = .now
        }
        
        let ok = UIAlertAction(title: "완료", style: .cancel) {  [weak self] action in
            var dateString: String? {
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "a hh:mm"
                let dateString = myFormatter.string(from: timePicker.date)
                return dateString
            }
            self?.detailView.timeSelectLabel.textColor = self?.colorHelper.fontColor
            self?.detailView.timeSelectLabel.text = dateString
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
            print("detailVC - ok button")
            navigationController?.popViewController(animated: true)
            return
        }
        if detailView.okLabel.text == "SAVE" {
            detailView.toDoData?.todoTitle = detailView.titleTextField.text
            detailView.toDoData?.todoDetailText = detailView.detailTextView.text
            todoManager.updateToDo(newToDoData: detailView.toDoData!) {  [weak self] in
                print("detailVC - Todo Data Changed!")
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
            // 얼럿창 생성
            //            let alert = UIAlertController(title: "일정 수정", message: "일정을 수정 하시겠습니까?", preferredStyle: .alert)
            // 예 선택
            let success = UIAlertAction(title: "예", style: .default) {  [weak self] action in
                print("'예'버튼이 눌렸습니다.")
                self?.detailView.editStatus = true
                self?.detailView.okLabel.text = "SAVE"
                self?.detailView.editLabel.text = "CANCEL"
                setOriginalButtonColor()
            }
            
            let cancel = UIAlertAction(title: "아니오", style: .cancel) {  action in
                print("'아니오'버튼이 눌렸습니다.")
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
                print("'예'버튼이 눌렸습니다.")
                self.navigationController?.popViewController(animated: true)
                setOriginalButtonColor()
            }
            
            let cancel = UIAlertAction(title: "아니오", style: .cancel) { action in
                print("'아니오'버튼이 눌렸습니다.")
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
    
    override func viewWillDisappear(_ animated: Bool) {
        print("DetailView 사라짐")
    }
}

// MARK: - extension
extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if detailView.editStatus == true {
            return true
        }
        return false
    }
    
    private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {        // 첫글자가 공백인지 확인
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
    // 입력 못하게 막기
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
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "(선택) 추가 내용을 입력해주세요."
            textView.textColor = ColorHelper().cancelBackgroundColor
        } else {
            textView.textColor = ColorHelper().fontColor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 1 {        // 첫글자가 공백인지 확인
            if textView.text?.first == " " {
                textView.text = ""
                return
            }
        }
        textView.textColor = ColorHelper().fontColor
    }
}


