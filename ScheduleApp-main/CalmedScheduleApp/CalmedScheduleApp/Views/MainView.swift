//
//  MainView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit


final class MainView: UIView {
    
    private let colorHelper = ColorHelper()
    
    var tempStatus: CGFloat = 0
    var moistStatus: CGFloat = 0
    var dustStatus: CGFloat = 0
    
    var dustResult: Item? {
        didSet {
            setUIwithData()
        }
    }
    
    func setUIwithData() {
        let dustResult = dustResult
        if dustResult != nil {
            dustResultLabel.text = dustResult?.informGrade
        } else {
            print("dustResult == nil")
        }
        
    }
    
    // MARK: - configure UI
    
    lazy var greetingLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
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
        label.text = "날짜 표시 안됨"
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
    
    lazy var tempView: UIView = {
       var view = UIView()
        view.backgroundColor = colorHelper.tempViewColor
        view.layer.cornerRadius = 5

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.5
        view.addSubview(tempResultLabel)
        return view
    }()
    
    lazy var tempLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "현재 기온"
        return label
    }()
    
    lazy var tempResultLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "적음"
        return label
    }()
    
    lazy var dustView: UIView = {
       var view = UIView()
        view.backgroundColor = colorHelper.dustViewColor
        view.layer.cornerRadius = 5

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.5
        view.addSubview(dustResultLabel)
        return view
    }()
    
    lazy var dustLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "미세먼지"
        return label
    }()
    
    lazy var dustResultLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "적음"
        return label
    }()
    
    lazy var moistView: UIView = {
       var view = UIView()
        view.backgroundColor = colorHelper.moistViewColor
        view.layer.cornerRadius = 5

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.5
        view.addSubview(moistResultLabel)
        return view
    }()
    
    lazy var moistLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "강수량"
        return label
    }()
    
    lazy var moistResultLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "적음"
        return label
    }()
    
    // MARK: - stackVeiw
    var customSpacingAnchor: CGFloat = 45
    
    lazy var labelStack: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [greetingLabel, dateLabel])
        stView.backgroundColor = .clear
        stView.spacing = customSpacingAnchor
        stView.axis = .vertical
        stView.alignment = .fill
        return stView
    }()
    
    lazy var weatherView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.addSubview(tempView)
        view.addSubview(dustView)
        view.addSubview(moistView)
        view.addSubview(tempLabel)
        view.addSubview(dustLabel)
        view.addSubview(moistLabel)
        return view
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
        addSubview(weatherView)
        labelAutolayout()
        scheduleViewAutolayout()
        weatherAutolayout()
    }
    
    
    // MARK: - set Autolayout
    func labelAutolayout() {
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        labelStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
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
        
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 8).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: labelStack.leadingAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor).isActive = true
        weatherView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -customSpacingAnchor).isActive = true
        
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dustView.translatesAutoresizingMaskIntoConstraints = false
        dustLabel.translatesAutoresizingMaskIntoConstraints = false
        
        moistView.translatesAutoresizingMaskIntoConstraints = false
        moistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //현재기온
        tempView.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor).isActive = true
        tempView.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor).isActive = true
        tempView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        tempLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        tempLabel.bottomAnchor.constraint(equalTo: tempView.topAnchor, constant: -5).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: tempView.leadingAnchor).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: tempView.trailingAnchor).isActive = true
        
        //미세먼지
        dustView.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor).isActive = true
        dustView.leadingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: 10).isActive = true
        dustView.widthAnchor.constraint(equalTo: tempView.widthAnchor).isActive = true
        
        dustLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dustLabel.bottomAnchor.constraint(equalTo: dustView.topAnchor, constant: -5).isActive = true
        dustLabel.leadingAnchor.constraint(equalTo: dustView.leadingAnchor).isActive = true
        dustLabel.trailingAnchor.constraint(equalTo: dustView.trailingAnchor).isActive = true
        
        // 강수량
        moistView.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor).isActive = true
        moistView.leadingAnchor.constraint(equalTo: dustView.trailingAnchor, constant: 10).isActive = true
        moistView.widthAnchor.constraint(equalTo: tempView.widthAnchor).isActive = true
        
        moistLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        moistLabel.bottomAnchor.constraint(equalTo: moistView.topAnchor, constant: -5).isActive = true
        moistLabel.leadingAnchor.constraint(equalTo: moistView.leadingAnchor).isActive = true
        moistLabel.trailingAnchor.constraint(equalTo: moistView.trailingAnchor).isActive = true
        
        // 현재기온 + 미세먼지 + 강수량 높이
        tempView.heightAnchor.constraint(equalToConstant: 60 + tempStatus).isActive = true
        dustView.heightAnchor.constraint(equalToConstant: 60 + dustStatus).isActive = true
        moistView.heightAnchor.constraint(equalToConstant: 60 + moistStatus).isActive = true
        
        tempResultLabel.translatesAutoresizingMaskIntoConstraints = false
        dustResultLabel.translatesAutoresizingMaskIntoConstraints = false
        moistResultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tempResultLabel.leadingAnchor.constraint(equalTo: tempView.leadingAnchor).isActive = true
        tempResultLabel.trailingAnchor.constraint(equalTo: tempView.trailingAnchor).isActive = true
        tempResultLabel.centerXAnchor.constraint(equalTo: tempView.centerXAnchor).isActive = true
        tempResultLabel.bottomAnchor.constraint(equalTo: tempView.bottomAnchor).isActive = true
        
        dustResultLabel.leadingAnchor.constraint(equalTo: dustView.leadingAnchor).isActive = true
        dustResultLabel.trailingAnchor.constraint(equalTo: dustView.trailingAnchor).isActive = true
        dustResultLabel.centerXAnchor.constraint(equalTo: dustView.centerXAnchor).isActive = true
        dustResultLabel.bottomAnchor.constraint(equalTo: dustView.bottomAnchor).isActive = true

        moistResultLabel.leadingAnchor.constraint(equalTo: moistView.leadingAnchor).isActive = true
        moistResultLabel.trailingAnchor.constraint(equalTo: moistView.trailingAnchor).isActive = true
        moistResultLabel.centerXAnchor.constraint(equalTo: moistView.centerXAnchor).isActive = true
        moistResultLabel.bottomAnchor.constraint(equalTo: moistView.bottomAnchor).isActive = true


    }
    
}


