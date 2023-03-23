//
//  StartViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/23.
//

import UIKit

class StartViewController: UIViewController {
    
    private let startView = StartView()
    private let colorHelper = ColorHelper()
    private let userDataManager = CoreDataManager.shared
    
    
    let pickerView = UIPickerView()
    
    
    override func loadView() {
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.nameTextField.delegate = self
        startView.cityTextField.delegate = self
        setActions()
    }
    
    
    // MARK: - set Actions
    func setActions() {
        startView.nameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        startView.cityTextField.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        startView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func selectCity() {
        //        let alert = UIAlertController(title: "도시 선택", message: "도시를 선택해주세요.", preferredStyle: .actionSheet)
        print("select city")
    }
    
    
    
    
    
    @objc private func okButtonTapped() {
        // 버튼 색 및 그림자 변화
        startView.okButton.layer.shadowOpacity = 0
        startView.okButton.layer.shadowColor = .none
        startView.okButton.backgroundColor = .lightGray
        
        let userName = startView.nameTextField.text
        let userCity = startView.cityTextField.text
        let alert = UIAlertController(title: "저장하시겠습니까?", message: "저장된 정보는 수정이 불가합니다.", preferredStyle: .alert)
        
        guard let text = userName, !text.isEmpty && text != " ", userCity != nil
        else {
            // 저장실패 얼럿 생성
            alert.title = "실패"
            alert.message = "정보를 기입해주세요."
            
            let failure = UIAlertAction(title: "돌아가기", style: .cancel) { action in
                print("유저 정보 불충분")
                self.startView.okButton.backgroundColor = self.colorHelper.yesButtonColor
                self.startView.okButton.layer.shadowColor = UIColor.black.cgColor
                self.startView.okButton.layer.shadowOpacity = 0.5
            }
            alert.addAction(failure)
            // 저장실패 얼럿 띄우기
            self.present(alert, animated: true, completion: nil)
            return
        }
        let ok = UIAlertAction(title: "저장", style: .default) { action in
            print("유저 정보 저장")
            self.startView.okButton.backgroundColor = self.colorHelper.yesButtonColor
            self.startView.okButton.layer.shadowColor = UIColor.black.cgColor
            self.startView.okButton.layer.shadowOpacity = 0.5
            self.userDataManager.saveUserData(userName: userName, userCity: userCity) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("유저 정보 불충분")
            self.startView.okButton.backgroundColor = self.colorHelper.yesButtonColor
            self.startView.okButton.layer.shadowColor = UIColor.black.cgColor
            self.startView.okButton.layer.shadowOpacity = 0.5
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        // 저장실패 얼럿 띄우기
        self.present(alert, animated: true, completion: nil)
        return
        
        
    }
}



// MARK: - Extension

extension StartViewController: UITextFieldDelegate {
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        startView.addSubview()
    }
}
