//
//  EditViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {

    let editView = EditView()
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let toDoManager = CoreDataManager.shared
    
    var toDoData: TodoData? {
        didSet {
            
        }
    }
    
   
    override func loadView() {
        view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //configureUI()
    }
    
    
    // MARK: - setup
    
    func setup() {
        editView.titleTextField.delegate = self
        editView.detailTextView.delegate = self
        
    }
//
//    func configureUI() {
//        // 기존데이터가 있을때
//        if let toDoData = self.toDoData {
//            self.title = "Edit"
//
////            guard let text = toDoData.memoText else { return }
////            mainTextView.text = text
////
////            mainTextView.textColor = .black
////            saveButton.setTitle("UPDATE", for: .normal)
////            mainTextView.becomeFirstResponder()
////            let color = MyColor(rawValue: toDoData.color)
////            setupColorTheme(color: color)
//
//        // 기존데이터가 없을때
//        } else {
//            self.title = "New !"
//
//            editView.titleTextField.placeholder = "일정의 제목을 입력해주세요."
//            editView.doneLabel.text = "ADD"
//            editView.cancelLabel.text = "CANCEL"
//
//        }
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}

extension EditViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "(선택) 추가 내용을 입력해주세요." {
            textView.text = nil
            textView.textColor = ColorHelper().fontColor
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
}

