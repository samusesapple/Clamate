//
//  StartView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/23.
//

import UIKit

final class StartView: UIView {

    private let colorHelper = ColorHelper()
    
    var shouldEnableButton: Bool {
        return nameTextField.text != nil && nameTextField.text?.first != " " && cityTextField.text != nil
        
    }
    
    lazy var greetingLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "안녕하세요,\n만나서 반갑습니다!"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "닉네임을 입력해주세요."
        return label
    }()
    
    lazy var nameTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
        view.frame.size.height = 48
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        view.addSubview(nameTextField)
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.backgroundColor = .clear
        tf.frame.size.height = 18
        tf.textColor = colorHelper.fontColor
        tf.tintColor = colorHelper.fontColor
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.smartInsertDeleteType = .no
        tf.clearButtonMode = .whileEditing
        tf.enablesReturnKeyAutomatically = true
        tf.becomeFirstResponder()
        tf.clearsOnBeginEditing = false
        tf.returnKeyType = .done
        tf.next?.resignFirstResponder()
        tf.attributedPlaceholder = NSAttributedString(string: "최대 7글자, 변경 불가능", attributes: [NSAttributedString.Key.foregroundColor : ColorHelper().cancelBackgroundColor])
        return tf
    }()
    
    lazy var nameStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [nameLabel, nameTextFieldView])
        stView.axis = .vertical
        stView.frame.size.height = 90
        stView.spacing = 20
        stView.alignment = .fill
        stView.distribution = .fill
        return stView
    }()
    

    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "자주 머무는 지역을 선택해주세요."
        return label
    }()
    
    lazy var cityTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5
        view.frame.size.height = 48
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.5
        view.addSubview(cityTextField)
        return view
    }()
    
    lazy var cityTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.backgroundColor = .clear
        tf.frame.size.height = 18
        tf.textColor = colorHelper.fontColor
        tf.tintColor = colorHelper.fontColor
        tf.smartInsertDeleteType = .no
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.enablesReturnKeyAutomatically = true
        tf.becomeFirstResponder()
        tf.clearsOnBeginEditing = false
        tf.returnKeyType = .done
        tf.next?.resignFirstResponder()
        tf.attributedPlaceholder = NSAttributedString(string: "날씨를 알려드립니다.", attributes: [NSAttributedString.Key.foregroundColor : ColorHelper().cancelBackgroundColor])
        return tf
    }()
    
    lazy var cityStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [cityLabel, cityTextFieldView])
        stView.axis = .vertical
        stView.frame.size.height = 90
        stView.spacing = 20
        stView.alignment = .fill
        stView.distribution = .fill
        return stView
    }()
    

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
        label.text = "Done"
        label.textColor = colorHelper.fontColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        self.backgroundColor = colorHelper.backgroundColor
        addSubview(greetingLabel)
        addSubview(nameStackView)
        addSubview(cityStackView)
        addSubview(okButton)
        setAutolayout()
    }
    
    func setAutolayout() {
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        greetingLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 45).isActive = true
        greetingLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -45).isActive = true
        
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 70).isActive = true
        nameStackView.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor, constant: 20).isActive = true
        nameStackView.trailingAnchor.constraint(equalTo: greetingLabel.trailingAnchor, constant: -25).isActive = true
        
        nameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        nameTextFieldView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        nameTextFieldView.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor).isActive = true
        nameTextFieldView.trailingAnchor.constraint(equalTo: nameStackView.trailingAnchor).isActive = true
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.leadingAnchor.constraint(equalTo: nameTextFieldView.leadingAnchor, constant: 13).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: nameTextFieldView.trailingAnchor, constant: -13).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: nameTextFieldView.centerYAnchor, constant: -1).isActive = true
        
        cityStackView.translatesAutoresizingMaskIntoConstraints = false
        cityStackView.topAnchor.constraint(equalTo: self.nameStackView.bottomAnchor, constant: 70).isActive = true
        cityStackView.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor).isActive = true
        cityStackView.trailingAnchor.constraint(equalTo: nameStackView.trailingAnchor).isActive = true
    
        cityTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        cityTextFieldView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        cityTextFieldView.leadingAnchor.constraint(equalTo: cityStackView.leadingAnchor).isActive = true
        cityTextFieldView.trailingAnchor.constraint(equalTo: cityStackView.trailingAnchor).isActive = true
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.leadingAnchor.constraint(equalTo: cityTextFieldView.leadingAnchor, constant: 13).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: cityTextFieldView.trailingAnchor, constant: -13).isActive = true
        cityTextField.centerYAnchor.constraint(equalTo: cityTextFieldView.centerYAnchor, constant: -1).isActive = true
        
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        okButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        okButton.topAnchor.constraint(equalTo: cityStackView.bottomAnchor, constant: 90).isActive = true
        
        okLabel.translatesAutoresizingMaskIntoConstraints = false
        okLabel.centerXAnchor.constraint(equalTo: okButton.centerXAnchor).isActive = true
        okLabel.centerYAnchor.constraint(equalTo: okButton.centerYAnchor).isActive = true
        
    }
    

    

}

    
