//
//  DetailView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit

final class AddView: UIView {
    
    private let colorHelper = ColorHelper()
    
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
        view.frame.size.height = 48
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
        tf.clearButtonMode = .whileEditing
        tf.enablesReturnKeyAutomatically = true
        tf.becomeFirstResponder()
        tf.clearsOnBeginEditing = false
        tf.returnKeyType = .next
        tf.next?.resignFirstResponder()
        tf.attributedPlaceholder = NSAttributedString(string: "일정의 제목을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : ColorHelper().cancelBackgroundColor])
        return tf
    }()
    
    lazy var titleStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [titleLabel, titleTextFieldView])
        stView.axis = .vertical
        stView.frame.size.height = 76
        stView.spacing = 7
        stView.alignment = .fill
        stView.distribution = .fill
        return stView
    }()
    
    
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
    
    lazy var dateSelectButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "날짜를 선택해주세요."
        button.backgroundColor = colorHelper.buttonColor
        button.layer.cornerRadius = 5
        button.frame.size.height = 48
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
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
    
    lazy var timeSelectButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "시간을 선택해주세요."
        button.backgroundColor = colorHelper.buttonColor
        button.layer.cornerRadius = 5
        button.frame.size.height = 48
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
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
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        view.addSubview(detailTextView)
        return view
    }()
    
    lazy var detailTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title3), size: 17)
        tv.textAlignment = .left
        tv.backgroundColor = .clear
        tv.textColor = colorHelper.cancelBackgroundColor
        tv.tintColor = colorHelper.fontColor
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.spellCheckingType = .no
        tv.text = "(선택) 추가 내용을 입력해주세요."
        tv.clearsOnInsertion = true
        
        return tv
    }()
    
    
    
    // buttons
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = colorHelper.yesButtonColor
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
        button.setTitle("ADD", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.titleLabel?.tintColor = colorHelper.fontColor
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = colorHelper.cancelBackgroundColor
        button.layer.cornerRadius = 5
        button.frame.size = CGSize(width: 100, height: 48)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.5
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.titleLabel?.tintColor = colorHelper.cancelTextColor
        return button
    }()

    lazy var buttonStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [cancelButton, addButton])
        stView.axis = .horizontal
        stView.spacing = 26
        stView.alignment = .fill
        stView.distribution = .fill
        return stView
    }()
    
    
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
        addSubview(titleStackView)
        addSubview(dateStackView)
        addSubview(timeStackView)
        addSubview(detailFieldView)
        addSubview(buttonStackView)
        
        setAutolayout()
    }
    
    private let customLeadingAnchor: CGFloat = 25
    private let customHeightAnchor: CGFloat = 48
    
    private func setAutolayout() {
        titleTFAutolayout()
        dateAutolayout()
        timeAutolayout()
        detailAutolayout()
        buttonAutolayout()
    }
    
    private func titleTFAutolayout() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        
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
        
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 18).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        dateStackView.heightAnchor.constraint(equalToConstant: customHeightAnchor).isActive = true
        
        dateSelectLabel.translatesAutoresizingMaskIntoConstraints = false
        dateSelectLabel.centerXAnchor.constraint(equalTo: dateSelectButton.centerXAnchor).isActive = true
        dateSelectLabel.centerYAnchor.constraint(equalTo: dateSelectButton.centerYAnchor).isActive = true
    }
    
    private func timeAutolayout() {
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
        
        timeSelectLabel.translatesAutoresizingMaskIntoConstraints = false
        timeSelectLabel.centerXAnchor.constraint(equalTo: timeSelectButton.centerXAnchor).isActive = true
        timeSelectLabel.centerYAnchor.constraint(equalTo: timeSelectButton.centerYAnchor)
            .isActive = true
        timeSelectLabel.widthAnchor.constraint(equalToConstant: 210).isActive = true
    }
    
    private func buttonAutolayout() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.lastBaselineAnchor, constant: -100).isActive = true
    }
    
    private func detailAutolayout() {
        detailFieldView.translatesAutoresizingMaskIntoConstraints = false
        detailFieldView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 18).isActive = true
        detailFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customLeadingAnchor).isActive = true
        detailFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        detailFieldView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -18).isActive = true
        
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.topAnchor.constraint(equalTo: detailFieldView.topAnchor, constant: 5).isActive = true
        detailTextView.leadingAnchor.constraint(equalTo: detailFieldView.leadingAnchor, constant: 10).isActive = true
        detailTextView.trailingAnchor.constraint(equalTo: detailFieldView.trailingAnchor, constant: -10).isActive = true
        detailTextView.bottomAnchor.constraint(equalTo: detailFieldView.bottomAnchor, constant: -6).isActive = true
    }
    
    
    
    
}
