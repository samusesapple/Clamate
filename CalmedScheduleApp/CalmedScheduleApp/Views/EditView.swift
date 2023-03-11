//
//  EditView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit

class EditView: UIView {

    private let colorHelper = ColorHelper()
    
    // MARK: - UI 생성
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Edit"
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
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        view.addSubview(titleTextField)
        return view
    }()
    
    lazy var titleTextField: UITextField = {
        let tf = UITextField()
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
        tf.attributedPlaceholder = NSAttributedString(string: "일정의 제목을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
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
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
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
    
    lazy var dateSelectView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
        view.frame.size.height = customHeightAnchor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        return view
    }()

    
    lazy var dateStackView: UIStackView = {
            let stView = UIStackView(arrangedSubviews: [dateView, dateSelectView])
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
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
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
    
    lazy var timeSelectView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
        view.frame.size.height = customHeightAnchor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        return view
    }()

    lazy var timeStackView: UIStackView = {
            let stView = UIStackView(arrangedSubviews: [timeView, timeSelectView])
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
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        //view.addSubview(titleTextField)
        return view
    }()
    
    
    
    // buttons
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorHelper.buttonColor
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
        button.addSubview(doneLabel)
        return button
    }()
    
    lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "ADD"
        label.textColor = colorHelper.fontColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorHelper.cancelBackgroundColor
        button.layer.cornerRadius = 5
        button.frame.size = CGSize(width: 100, height: 48)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
        button.addSubview(cancelLabel)
        return button
    }()
    
    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "CANCEL"
        label.textColor = colorHelper.cancelTextColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()

    lazy var buttonStackView: UIStackView = {
            let stView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
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
    func configureUI() {
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
    let customLeadingAnchor: CGFloat = 25
    let customTopAnchor: CGFloat = 18
    let customHeightAnchor: CGFloat = 48
    
    func setAutolayout() {
        mainLabelAutolayout()
        titleTFAutolayout()
        dateAutolayout()
        timeAutolayout()
        detailAutolayout()
        buttonAutolayout()
    }
    
    func mainLabelAutolayout() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
    }
    
    func titleTFAutolayout() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 130).isActive = true
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
    
    func dateAutolayout() {
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor, constant: 1).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor, constant: -1).isActive = true
        
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: customTopAnchor).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        dateStackView.heightAnchor.constraint(equalToConstant: customHeightAnchor).isActive = true
    }
    
    func timeAutolayout() {
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: timeView.centerXAnchor, constant: 1).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor, constant: -1).isActive = true
        
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 7).isActive = true
        timeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        timeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        timeStackView.heightAnchor.constraint(equalToConstant: customHeightAnchor).isActive = true
    }
    
    func detailAutolayout() {
        detailFieldView.translatesAutoresizingMaskIntoConstraints = false
        detailFieldView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: customTopAnchor).isActive = true
        detailFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        detailFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        detailFieldView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func buttonAutolayout() {
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        doneLabel.centerXAnchor.constraint(equalTo: doneButton.centerXAnchor, constant: 0).isActive = true
        doneLabel.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor, constant: 0).isActive = true
        
        cancelLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelLabel.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor, constant: 0).isActive = true
        cancelLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor, constant: 0).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.lastBaselineAnchor, constant: -100).isActive = true
    }

}
