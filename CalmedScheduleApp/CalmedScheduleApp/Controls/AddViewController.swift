//
//  AddViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit

class AddViewController: UIViewController {
    
    let addView = AddView()
    
    let toDoManager = CoreDataManager.shared
    
    
    
    override func loadView() {
        view = addView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        addView.titleTextField.delegate = self
        addView.detailTextView.delegate = self
        addView.detailTextView.resignFirstResponder()
        
        setActions()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - set Actions
    func setActions() {
        addView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        addView.titleTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: - addTarget for buttons
    @objc func addButtonTapped() {
        
        let titleText = addView.titleTextField.text
        let detailText = addView.detailTextView.text
        let todoDate = addView.datePicker.date
        let todoTime = addView.timePicker.date
        guard let text = titleText, !text.isEmpty && text != " " else {
            // 저장실패 얼럿 생성
            let failureAlert = UIAlertController(title: "추가 실패", message: "일정의 제목을 입력해주세요.", preferredStyle: .alert)
            
            let failure = UIAlertAction(title: "돌아가기", style: .cancel) { action in
                print("저장 실패")
            }
            failureAlert.addAction(failure)
            // 저장실패 얼럿 띄우기
            self.present(failureAlert, animated: true, completion: nil)
            
            return
        }
        
        // 저장 완료 얼럿 생성
        let successAlert = UIAlertController(title: "추가 완료", message: "일정이 추가 되었습니다.", preferredStyle: .alert)
  
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("'저장 확인'버튼이 눌렸습니다.")
            // 코어데이터 추가
            self.toDoManager.saveToDoData(todoDate: todoDate, todoTime: todoTime, todoTitle: titleText, todoDetail: detailText, todoDone: false, completion: {
                print("저장완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            })
        }
        successAlert.addAction(success)
        // 저장 완료 얼럿 실행
        self.present(successAlert, animated: true, completion: nil)

        
    }
    
    
    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - extension
extension AddViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "(선택) 추가 내용을 입력해주세요." {
            textView.text = nil
            textView.textColor = ColorHelper().cancelBackgroundColor
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "(선택) 추가 내용을 입력해주세요."
            textView.textColor = ColorHelper().cancelBackgroundColor
        }
    }
    
     func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 1 {        // 첫글자가 공백인지 확인
            if textView.text?.first == " " {
                textView.text = ""
                return
            }
        }
    }
    
}

extension AddViewController: UITextFieldDelegate {
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {        // 첫글자가 공백인지 확인
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
    }
}
