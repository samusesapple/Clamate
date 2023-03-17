//
//  MainView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit


final class MainView: UIView {
    
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
        label.textAlignment = .right
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "영하 1도, 강수 30%"
        return label
    }()
    
    lazy var scheduleView: UIView = {
       var view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.frame.size = CGSize(width: 300, height: 160)
        view.layer.cornerRadius = 5
  
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.5
        return view
    }()
    
    lazy var weatherLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Weather"
        return label
    }()
    
    lazy var weatherView1: UIView = {
       var view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.5
        return view
    }()
    
    lazy var weatherView2: UIView = {
       var view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.5
        return view
    }()
    
    lazy var weatherView3: UIView = {
       var view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.layer.cornerRadius = 5

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.5
        return view
    }()
    
    // MARK: - stackVeiw
    var customSpacingAnchor: CGFloat = 45
    
    lazy var labelStack: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [greetingLabel, dateLabel])
        stView.backgroundColor = .clear
        stView.spacing = customSpacingAnchor
        stView.axis = .vertical
        stView.alignment = .fill
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    lazy var weatherViewStack: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [weatherView1, weatherView2, weatherView3])
        stView.backgroundColor = .clear
        stView.spacing = 10
        stView.distribution = .fillEqually
        stView.axis = .vertical
        stView.alignment = .fill
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
        addSubview(scheduleView)
        addSubview(weatherLabel)
        addSubview(weatherViewStack)
        labelAutolayout()
        scheduleViewAutolayout()
        weatherAutolayout()
    }
    
    
    // MARK: - set Autolayout
    func labelAutolayout() {
        labelStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        labelStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
    }
    
    func scheduleViewAutolayout() {
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        scheduleView.leadingAnchor.constraint(equalTo: labelStack.leadingAnchor).isActive = true
        scheduleView.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor).isActive = true
        scheduleView.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 8).isActive = true
        scheduleView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func weatherAutolayout() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.topAnchor.constraint(equalTo: scheduleView.bottomAnchor, constant: customSpacingAnchor).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: scheduleView.leadingAnchor).isActive = true
        
        
        weatherViewStack.translatesAutoresizingMaskIntoConstraints = false
        weatherView1.translatesAutoresizingMaskIntoConstraints = false
        weatherView2.translatesAutoresizingMaskIntoConstraints = false
        weatherView3.translatesAutoresizingMaskIntoConstraints = false
        weatherView1.heightAnchor.constraint(equalToConstant: 60).isActive = true
        weatherView2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        weatherView3.heightAnchor.constraint(equalToConstant: 60).isActive = true
        weatherViewStack.leadingAnchor.constraint(equalTo: labelStack.leadingAnchor).isActive = true
        weatherViewStack.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor).isActive = true
        weatherViewStack.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 8).isActive = true
    }
    
}


