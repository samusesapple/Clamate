//
//  StartViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/23.
//

import UIKit

final class StartViewController: UIViewController {
    
    private let startView = StartView()
    private let colorHelper = ColorHelper()
    private let userDataManager = CoreDataManager.shared
    private let networkManager = NetworkManager.shared
    private let weatherDataManager = WeatherDataManager.shared
    
    private let location = ["Seoul", "Incheon", "Seongnam", "Suwon", "Osan", "Ansan", "Seosan",  "Cheonan", "Cheongju", "Chuncheon", "Gangneung", "Sokcho", "Yeosu", "Daejeon", "Daegu", "Busan", "Ulsan", "Jeonju", "Gwangju", "Changwon", "Jeju"]
    private var focusedRow: Int = 0
    private var selectedRow: Int = 0

    
    override func loadView() {
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.nameTextField.delegate = self
        startView.cityTextField.delegate = self
        setActions()
    }
    
    func setActions() {
        startView.nameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        startView.cityTextField.addTarget(self, action: #selector(selectCity), for: .allTouchEvents)
        startView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func selectCity() {
        print(#function)
        let pickerView = UIPickerView()
        let alert = UIAlertController(title: "지역 선택", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "확인", style: .cancel) { [weak self] _ in
            self?.selectedRow = self!.focusedRow
    
        })
        
        pickerView.frame = CGRect(x: 50, y: 50, width: 270, height: 130)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        alert.view.addSubview(pickerView)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc private func okButtonTapped() {
        print(#function)
        startView.okButton.layer.shadowOpacity = 0
        startView.okButton.layer.shadowColor = .none
        startView.okButton.backgroundColor = .lightGray
        
        let userName = startView.nameTextField.text
        let userCity = startView.cityTextField.text
        let alert = UIAlertController(title: "저장 하시겠습니까?", message: "저장된 정보는 수정이 불가합니다.", preferredStyle: .alert)
        
        guard let text = userName, !text.isEmpty && text != " ", userCity != nil
        else {
            alert.title = "실패"
            alert.message = "정보를 기입해주세요."
            
            let failure = UIAlertAction(title: "돌아가기", style: .cancel) { action in
                self.startView.okButton.backgroundColor = self.colorHelper.yesButtonColor
                self.startView.okButton.layer.shadowColor = UIColor.black.cgColor
                self.startView.okButton.layer.shadowOpacity = 0.5
            }
            alert.addAction(failure)
            // 저장실패 얼럿 띄우기
            self.present(alert, animated: true, completion: nil)
            return
        }
        let ok = UIAlertAction(title: "저장", style: .default) { [weak self] action in
            self?.startView.okButton.backgroundColor = self?.colorHelper.yesButtonColor
            self?.startView.okButton.layer.shadowColor = UIColor.black.cgColor
            self?.startView.okButton.layer.shadowOpacity = 0.5
            self?.userDataManager.saveUserData(userName: userName, userCity: userCity) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }

        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { [weak self] action in
            self?.startView.okButton.backgroundColor = self?.colorHelper.yesButtonColor
            self?.startView.okButton.layer.shadowColor = UIColor.black.cgColor
            self?.startView.okButton.layer.shadowOpacity = 0.5
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        return
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}



extension StartViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == startView.cityTextField {
            return false
        }
        return true
    }
    
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

extension StartViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return location.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return location[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        focusedRow = row
        startView.cityTextField.text = location[focusedRow]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 30
    }
    
}
