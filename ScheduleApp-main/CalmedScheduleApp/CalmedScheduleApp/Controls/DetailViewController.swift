//
//  DetailViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/15.
//

import UIKit

final class DetailViewController: UIViewController {
    let detailView = DetailView()
    let colorHelper = ColorHelper()
    let todoManager = CoreDataManager.shared
    var toDoData: TodoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.detailTextView.delegate = self
        detailView.titleTextField.delegate = self
        setActions()
    }
    
    // MARK: - configure UI with Data
    func configureUIwithData() {
        detailView.titleTextField.text = toDoData?.todoTitle
        detailView.dateSelectlabel.text = toDoData?.longDateString
        detailView.timeSelectlabel.text = toDoData?.timeString
        detailView.detailTextView.text = toDoData?.todoDetailText
        if detailView.detailTextView.text == "" {
            detailView.detailTextView.text = "작성된 추가 내용이 없습니다."
            detailView.detailTextView.textColor = colorHelper.cancelBackgroundColor
        }
    }
    
    
    // MARK: - set Actions
    func setActions() {
        detailView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        detailView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func okButtonTapped() {
        print("detailVC - ok button")
        detailView.okButton.backgroundColor = .lightGray
        self.dismiss(animated: true)
    }
    
    @objc func editButtonTapped() {
        print("detailVC - edit button")
        detailView.editButton.backgroundColor = .lightGray
        func setOriginalButtonColor() { self.detailView.editButton.backgroundColor = self.colorHelper.cancelBackgroundColor }
        // 얼럿창 생성
        let alert = UIAlertController(title: "일정 수정", message: "일정을 수정 하시겠습니까?", preferredStyle: .alert)
        // 얼럿창에 들어갈 액션 선택지 생성
        let success = UIAlertAction(title: "예", style: .default) { action in
            print("'예'버튼이 눌렸습니다.")
            setOriginalButtonColor()
        }
        let cancel = UIAlertAction(title: "아니오", style: .cancel) { action in
            print("'아니오'버튼이 눌렸습니다.")
            setOriginalButtonColor()
        }
        alert.addAction(success)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        return
    }
    
}

// MARK: - extension
extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

extension DetailViewController: UITextViewDelegate {
    // 입력 못하게 막기
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}


