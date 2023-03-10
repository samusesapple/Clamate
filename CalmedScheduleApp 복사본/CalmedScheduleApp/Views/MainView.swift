//
//  MainView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit


class MainView: UIView {
    
    private let colorHelper = ColorHelper()
    
    lazy var greetingLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "현관님, \n오늘도 화이팅하세요!"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "2023년 3월 8일"
        return label
    }()
    
    lazy var weatherLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .right
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "영하 1도, 강수 30%"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    lazy var scheduleButton1: UIButton = {
       var button = UIButton()
        button.backgroundColor = colorHelper.buttonColor
        button.frame.size = CGSize(width: 300, height: 160)
        button.layer.cornerRadius = 5
  
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 2.5
        return button
    }()
    
    lazy var scheduleButton2: UIButton = {
       var button = UIButton()
        button.backgroundColor = colorHelper.buttonColor
        button.layer.cornerRadius = 5

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 2.5
        return button
    }()
    
    
    // MARK: - stackVeiw
    var customSpacingAnchor: CGFloat = 32
    
    lazy var labelStack: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [greetingLabel, dateLabel, weatherLabel])
        stView.backgroundColor = .clear
        stView.spacing = customSpacingAnchor
        stView.axis = .vertical
        stView.alignment = .fill
        stView.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(labelStack)
        addSubview(scheduleButton1)
        addSubview(scheduleButton2)
        labelAutolayout()
        button1Autolayout()
        button2Autolayout()
    }
    
    
    // MARK: - set Autolayout
    func labelAutolayout() {
        labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        labelStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 140).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
    }
    
    func button1Autolayout() {
        scheduleButton1.translatesAutoresizingMaskIntoConstraints = false
        scheduleButton1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        scheduleButton1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        scheduleButton1.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 20).isActive = true
        scheduleButton1.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    func button2Autolayout() {
        scheduleButton2.translatesAutoresizingMaskIntoConstraints = false
        scheduleButton2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        scheduleButton2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        scheduleButton2.topAnchor.constraint(equalTo: scheduleButton1.bottomAnchor, constant: 30).isActive = true
        scheduleButton2.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
}
