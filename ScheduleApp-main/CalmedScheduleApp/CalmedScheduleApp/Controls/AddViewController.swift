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
        setUIwithDate()
    }
    
    private func setup() {
        addView.titleTextField.delegate = self
        addView.detailTextView.delegate = self
        
        tabBarController?.tabBar.isHidden = true
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
    
    // MARK: - addTarget for buttons
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
        
        var todayDateString: String? {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
            let dateString = myFormatter.string(from: Date())
            return dateString
        }
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "ko_KR")
        if addView.dateSelectLabel.text == todayDateString {
            timePicker.minimumDate = .now
        } else if addView.dateSelectLabel.text == "날짜를 선택해주세요." {
            timePicker.minimumDate = .now
        }
        
        let ok = UIAlertAction(title: "완료", style: .cancel) {  [weak self] action in
            var dateString: String? {
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "a hh:mm"
                let dateString = myFormatter.string(from: timePicker.date)
                return dateString
            }
            self?.addView.timeSelectLabel.textColor = self?.colorHelper.fontColor
            self?.addView.timeSelectLabel.text = dateString
            self?.selectedTime = timePicker.date
        }
        
        alert.addAction(ok)
        
        let vc = AddViewController()
        vc.view = timePicker
        
        alert.setValue(vc, forKey: "contentViewController")
        
        present(alert, animated: true)
    }
    
    @objc private func addButtonTapped() {
        // 버튼 색 및 그림자 변화
        addView.addButton.layer.shadowOpacity = 0
        addView.addButton.layer.shadowColor = .none
        addView.addButton.backgroundColor = .lightGray
        
        let titleText = addView.titleTextField.text
        let detailText = addView.detailTextView.text
        let todoDate = self.selectedDate
        let todoTime = self.selectedTime
        guard let text = titleText, !text.isEmpty && text != " ", todoDate != nil, todoTime != nil
        else {
            // 저장실패 얼럿 생성
            let failureAlert = UIAlertController(title: "추가 실패", message: "일정의 정보를 기입해주세요.", preferredStyle: .alert)
            
            let failure = UIAlertAction(title: "돌아가기", style: .cancel) {  [weak self] action in
                print("저장 실패")
                self?.addView.addButton.backgroundColor = self?.colorHelper.yesButtonColor
                self?.addView.addButton.layer.shadowColor = UIColor.black.cgColor
                self?.addView.addButton.layer.shadowOpacity = 0.5
            }
            failureAlert.addAction(failure)
            // 저장실패 얼럿 띄우기
            present(failureAlert, animated: true, completion: nil)
            
            return
        }
        self.toDoManager.saveToDoData(todoDate: todoDate, todoTime: todoTime, todoTitle: titleText, todoDetail: detailText, todoDone: false, completion: {  [weak self] in
            print("저장 완료")
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
        tabBarController?.tabBar.isHidden = false
    }
    
}
// MARK: - extension

extension AddViewController: UITextFieldDelegate {
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
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

extension AddViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "(선택) 추가 내용을 입력해주세요." {
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


