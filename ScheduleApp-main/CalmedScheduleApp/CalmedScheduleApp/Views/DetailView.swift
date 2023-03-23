//
//  EditView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit

final class DetailView: UIView {

    private let colorHelper = ColorHelper()
    
    var editStatus: Bool? {
        didSet {
            if editStatus == true {
                editAllowed()
            }
        }
    }
    
    var toDoData: TodoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // MARK: - configure UI with Data
    private func configureUIwithData() {
        titleTextField.text = toDoData?.todoTitle
        dateSelectLabel.text = toDoData?.longDateString
        timeSelectLabel.text = toDoData?.timeString
        detailTextView.text = toDoData?.todoDetailText
        if detailTextView.text == "" || detailTextView.text == "(선택) 추가 내용을 입력해주세요." {
            detailTextView.text = "작성된 추가 내용이 없습니다."
            detailTextView.textColor = colorHelper.cancelBackgroundColor
        }
    }
    
    private func editAllowed() {
        titleTextFieldView.layer.shadowColor = UIColor.black.cgColor
        titleTextFieldView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        titleTextFieldView.layer.shadowOpacity = 0.5
        titleTextFieldView.layer.shadowRadius = 2.5
        
        dateView.layer.shadowColor = UIColor.black.cgColor
        dateView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        dateView.layer.shadowOpacity = 0.5
        dateView.layer.shadowRadius = 2.5
        
        dateSelectButton.layer.shadowColor = UIColor.black.cgColor
        dateSelectButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        dateSelectButton.layer.shadowOpacity = 0.5
        dateSelectButton.layer.shadowRadius = 2.5
        
        timeView.layer.shadowColor = UIColor.black.cgColor
        timeView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        timeView.layer.shadowOpacity = 0.5
        timeView.layer.shadowRadius = 2.5
        
        timeSelectButton.layer.shadowColor = UIColor.black.cgColor
        timeSelectButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        timeSelectButton.layer.shadowOpacity = 0.5
        timeSelectButton.layer.shadowRadius = 2.5
        
        detailFieldView.layer.shadowColor = UIColor.black.cgColor
        detailFieldView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        detailFieldView.layer.shadowOpacity = 0.5
        detailFieldView.layer.shadowRadius = 2.5
    }
    // MARK: - UI 생성
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Detail"
        return label
    }()
    
    // title
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Title ;"
        return label
    }()
    
    lazy var titleTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
        view.frame.size.height = customHeightAnchor
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 2.5
        view.addSubview(titleTextField)
        return view
    }()
    
    lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.text = ""
        tf.textAlignment = .left
        tf.backgroundColor = .clear
        tf.frame.size.height = 18
        tf.textColor = colorHelper.fontColor
        tf.tintColor = colorHelper.fontColor
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.clearsOnBeginEditing = false
        tf.attributedPlaceholder = NSAttributedString(string: "일정의 제목을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : ColorHelper().cancelBackgroundColor])
        tf.becomeFirstResponder()
        return tf
    }()
    
    // titleLabel + titleTextField stack
    lazy var titleStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [titleLabel, titleTextFieldView])
        stView.axis = .vertical
        stView.frame.size.height = 21 + 7 + customHeightAnchor
        stView.spacing = 7
        stView.alignment = .fill
        stView.distribution = .fill
        return stView
    }()
    
    
    
    // date
    lazy var dateView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
        view.frame.size = CGSize(width: 100, height: 48)
        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 2.5
        view.addSubview(dateLabel)
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Date"
        label.textColor = colorHelper.fontColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var dateSelectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorHelper.buttonColor
        button.layer.cornerRadius = 5
        button.frame.size.height = customHeightAnchor
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 2.5
        button.addSubview(dateSelectLabel)
        return button
    }()

    lazy var dateSelectLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Date"
        label.textColor = colorHelper.fontColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var dateStackView: UIStackView = {
            let stView = UIStackView(arrangedSubviews: [dateView, dateSelectButton])
            stView.axis = .horizontal
            stView.spacing = 11
            stView.alignment = .fill
            stView.distribution = .fill
            return stView
        }()
    
    
    // time
    lazy var timeView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
        view.frame.size = CGSize(width: 100, height: 48)
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 2.5
        view.addSubview(timeLabel)
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Time"
        label.textColor = colorHelper.fontColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var timeSelectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorHelper.buttonColor
        button.layer.cornerRadius = 5
        button.frame.size.height = customHeightAnchor
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 2.5
        button.addSubview(timeSelectLabel)
        return button
    }()
    
    lazy var timeSelectLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Time"
        label.textColor = colorHelper.fontColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()

    lazy var timeStackView: UIStackView = {
            let stView = UIStackView(arrangedSubviews: [timeView, timeSelectButton])
            stView.axis = .horizontal
            stView.spacing = 11
            stView.alignment = .fill
            stView.distribution = .fill
            return stView
        }()
    
    
    
    // detail
    lazy var detailFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 2.5
        view.addSubview(detailTextView)
        return view
    }()
    
    lazy var detailTextView: UITextView = {
       let tv = UITextView()
        tv.text = " "
        tv.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title3), size: 17)
        tv.textAlignment = .left
        tv.backgroundColor = .clear
        tv.textColor = colorHelper.fontColor
        tv.tintColor = colorHelper.fontColor
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.spellCheckingType = .no
        
        return tv
    }()
    
    
    
    
    // buttons
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorHelper.yesButtonColor
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
        button.addSubview(okLabel)
        return button
    }()
    
    lazy var okLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "OK"
        label.textColor = colorHelper.fontColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorHelper.cancelBackgroundColor
        button.layer.cornerRadius = 5
        button.frame.size = CGSize(width: 100, height: 48)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
        button.addSubview(editLabel)
        return button
    }()
    
    lazy var editLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "EDIT"
        label.textColor = colorHelper.cancelTextColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()

    lazy var buttonStackView: UIStackView = {
            let stView = UIStackView(arrangedSubviews: [editButton, okButton])
            stView.axis = .horizontal
            stView.spacing = 26
            stView.alignment = .fill
            stView.distribution = .fill
            return stView
        }()
    
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - configureUI method
    private func configureUI() {
        self.backgroundColor = colorHelper.backgroundColor
        addSubview(mainLabel)
        addSubview(titleStackView)
        addSubview(dateStackView)
        addSubview(timeStackView)
        addSubview(detailFieldView)
        addSubview(buttonStackView)
        
        setAutolayout()
    }
    
    // MARK: - set Autolayout()
    var customTopAnchor: CGFloat = 18
    private let customLeadingAnchor: CGFloat = 25
    private let customHeightAnchor: CGFloat = 48
    
    private func setAutolayout() {
        mainLabelAutolayout()
        titleTFAutolayout()
        dateAutolayout()
        timeAutolayout()
        detailAutolayout()
        buttonAutolayout()
    }
    
    private func mainLabelAutolayout() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: customTopAnchor).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
    }
    
    private func titleTFAutolayout() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: customTopAnchor + 100).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        
        titleTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        titleTextFieldView.heightAnchor.constraint(equalToConstant: customHeightAnchor).isActive = true
        titleTextFieldView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor, constant: 0).isActive = true
        titleTextFieldView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor, constant: 0).isActive = true
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.leadingAnchor.constraint(equalTo: titleTextFieldView.leadingAnchor, constant: 13).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: titleTextFieldView.trailingAnchor, constant: -13).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: titleTextFieldView.centerYAnchor, constant: -1).isActive = true
        
    }
    
    private func dateAutolayout() {
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor, constant: 1).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor, constant: -1).isActive = true
        
        dateSelectLabel.translatesAutoresizingMaskIntoConstraints = false
        dateSelectLabel.centerXAnchor.constraint(equalTo: dateSelectButton.centerXAnchor, constant: -10).isActive = true
        dateSelectLabel.centerYAnchor.constraint(equalTo: dateSelectButton.centerYAnchor).isActive = true
        
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: customTopAnchor).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        dateStackView.heightAnchor.constraint(equalToConstant: customHeightAnchor).isActive = true
    }
    
    private func timeAutolayout() {
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: timeView.centerXAnchor, constant: 1).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor, constant: -1).isActive = true
        
        timeSelectLabel.translatesAutoresizingMaskIntoConstraints = false
        timeSelectLabel.centerXAnchor.constraint(equalTo: timeSelectButton.centerXAnchor, constant: -10).isActive = true
        timeSelectLabel.centerYAnchor.constraint(equalTo: timeSelectButton.centerYAnchor).isActive = true
        
        
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 7).isActive = true
        timeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        timeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        timeStackView.heightAnchor.constraint(equalToConstant: customHeightAnchor).isActive = true
    }
    
    private func buttonAutolayout() {
        okLabel.translatesAutoresizingMaskIntoConstraints = false
        okLabel.centerXAnchor.constraint(equalTo: okButton.centerXAnchor, constant: 0).isActive = true
        okLabel.centerYAnchor.constraint(equalTo: okButton.centerYAnchor, constant: 0).isActive = true
        
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        editLabel.centerXAnchor.constraint(equalTo: editButton.centerXAnchor, constant: 0).isActive = true
        editLabel.centerYAnchor.constraint(equalTo: editButton.centerYAnchor, constant: 0).isActive = true
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.lastBaselineAnchor, constant: -100).isActive = true
    }

    private func detailAutolayout() {
        detailFieldView.translatesAutoresizingMaskIntoConstraints = false
        detailFieldView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: customTopAnchor).isActive = true
        detailFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        detailFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        detailFieldView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -customTopAnchor).isActive = true
        
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.topAnchor.constraint(equalTo: detailFieldView.topAnchor, constant: 3).isActive = true
        detailTextView.leadingAnchor.constraint(equalTo: detailFieldView.leadingAnchor, constant: 8).isActive = true
        detailTextView.trailingAnchor.constraint(equalTo: detailFieldView.trailingAnchor, constant: -8).isActive = true
        detailTextView.bottomAnchor.constraint(equalTo: detailFieldView.bottomAnchor, constant: -6).isActive = true
    }
}
