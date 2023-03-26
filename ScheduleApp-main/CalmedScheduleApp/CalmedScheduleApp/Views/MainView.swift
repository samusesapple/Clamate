//
//  MainView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit


final class MainView: UIView {
    
    private let colorHelper = ColorHelper()
    
    var tempResult: Double? {
        didSet {
            setTempUIwithAPIData()
        }
    }
    
    var dustResult: Int? {
        didSet {
            setDustUIwithAPIData()
        }
    }
    
    var moistResult: Int? {
        didSet {

        }
    }

    var userData: UserData? {
        didSet {
            setUserData()
        }
    }
    
    
    
    // MARK: - configure UI
    
    lazy var greetingLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "유저 정보가 없습니다."
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
        view.addSubview(scheduleLabel)
        return view
    }()
    
    lazy var scheduleLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "일정이 없습니다."
        return label
    }()
    
    lazy var weatherLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = colorHelper.fontColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Weather"
        label.isUserInteractionEnabled = true
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
    
    // MARK: - stackVeiw
    
    lazy var labelStack: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [greetingLabel, dateLabel])
        stView.backgroundColor = .clear
        stView.spacing = 45
        stView.axis = .vertical
        stView.alignment = .fill
        return stView
    }()
    
    lazy var weatherView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.addSubview(dustView)
        view.addSubview(tempView)
        view.addSubview(tempLabel)
        view.addSubview(dustLabel)
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
    private func configureUI() {
        self.backgroundColor = colorHelper.backgroundColor
        addSubview(labelStack)
        addSubview(scheduleView)
        addSubview(weatherLabel)
        addSubview(weatherView)
        labelAutolayout()
        scheduleViewAutolayout()
        weatherAutolayout()
    }
    
    private func setUserData() {
        weatherLabel.text = "📍\(userData?.userCity! ?? "Weather")"
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            case 1...6:
            greetingLabel.text = "\(userData?.userName! ?? "유저")님, \n편안한 새벽 되세요 :)"
            case 7...11:
            greetingLabel.text = "\(userData?.userName! ?? "유저")님, \n오늘 하루도 응원해요!"
            case 12...18:
            greetingLabel.text = "\(userData?.userName! ?? "유저")님, \n오후 시간도 화이팅!"
            case 19...21:
            greetingLabel.text = "\(userData?.userName! ?? "유저")님, \n행복한 저녁 되세요 :)"
            default:
            greetingLabel.text = "\(userData?.userName! ?? "유저")님, \n오늘도 수고했어요 :)"
         }
    }
    
    private func setTempUIwithAPIData() {
        if let tempResult = tempResult {
            tempResultLabel.text = "\(String(tempResult))°C"
            var tempStatus = 0
            switch tempResult {
            case _ where tempResult < 0: tempStatus = 0
            case _ where  0 <= tempResult && tempResult < 11: tempStatus = Int(tempResult) + 30
            case _ where  11 <= tempResult && tempResult < 18 : tempStatus = Int(tempResult) + 60
            case _ where 18 <= tempResult && tempResult < 27 : tempStatus = Int(tempResult) + 90
            case _ where 27 <= tempResult : tempStatus = Int(tempResult) + 120
            default: dustResultLabel.text = "Loading"
                tempStatus = 0
            }
            DispatchQueue.main.async { [weak self] in
                MainView.animate(withDuration: 0.5) {
                    self?.tempView.heightConstraint?.constant = 60 + CGFloat(tempStatus)
                    self?.tempView.layoutIfNeeded()
                }
            }
        } else {
            tempResultLabel.text = "Loading"
        }
    }
    
    
    private func setDustUIwithAPIData() {
        var dustStatus = 0
        if let dustResult = dustResult {
            switch dustResult {
            case _ where  0 <= dustResult && dustResult <= 50: dustResultLabel.text = "좋음"
                dustStatus = 0
            case _ where  51 <= dustResult && dustResult <= 100: dustResultLabel.text = "보통"
                dustStatus = 40
            case _ where  101 <= dustResult && dustResult <= 150: dustResultLabel.text = "민감군 위험"
                dustStatus = 80
            case _ where  151 <= dustResult && dustResult <= 200: dustResultLabel.text = "위험"
                dustStatus = 120
            case _ where  201 <= dustResult && dustResult <= 300: dustResultLabel.text = "매우 위험"
                dustStatus = 160
            case _ where  301 <= dustResult: dustResultLabel.text = "비상"
                dustStatus = 200
            default: dustResultLabel.text = "Loading"
                dustStatus = 0
            }
            DispatchQueue.main.async { [weak self] in
                MainView.animate(withDuration: 0.5) {
                    self?.dustView.heightConstraint?.constant = 60 + CGFloat(dustStatus)
                    self?.dustView.layoutIfNeeded()
                }
            }
        }
    }
    
    
    // MARK: - set Autolayout
    private func labelAutolayout() {
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        labelStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
    }
    
    private func scheduleViewAutolayout() {
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        scheduleView.leadingAnchor.constraint(equalTo: labelStack.leadingAnchor).isActive = true
        scheduleView.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor).isActive = true
        scheduleView.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 8).isActive = true
        scheduleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        scheduleLabel.centerXAnchor.constraint(equalTo: scheduleView.centerXAnchor).isActive = true
        scheduleLabel.centerYAnchor.constraint(equalTo: scheduleView.centerYAnchor).isActive = true
    }
    
    private func weatherAutolayout() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.topAnchor.constraint(equalTo: scheduleView.bottomAnchor, constant: 45).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: scheduleView.leadingAnchor).isActive = true
        
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 8).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: labelStack.leadingAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor).isActive = true
        weatherView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true

        
        dustView.translatesAutoresizingMaskIntoConstraints = false
        dustLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //미세먼지
        dustView.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor).isActive = true
        dustView.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: 10).isActive = true
        dustView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dustLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dustLabel.bottomAnchor.constraint(equalTo: dustView.topAnchor, constant: -5).isActive = true
        dustLabel.leadingAnchor.constraint(equalTo: dustView.leadingAnchor).isActive = true
        dustLabel.trailingAnchor.constraint(equalTo: dustView.trailingAnchor).isActive = true
        
        //현재기온
        tempView.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor).isActive = true
        tempView.trailingAnchor.constraint(equalTo: dustView.leadingAnchor, constant: -15).isActive = true
        tempView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        tempLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        tempLabel.bottomAnchor.constraint(equalTo: tempView.topAnchor, constant: -5).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: tempView.leadingAnchor).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: tempView.trailingAnchor).isActive = true
        

        
        // 현재기온 + 미세먼지
        
        tempView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        dustView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        tempResultLabel.translatesAutoresizingMaskIntoConstraints = false
        dustResultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tempResultLabel.leadingAnchor.constraint(equalTo: tempView.leadingAnchor).isActive = true
        tempResultLabel.trailingAnchor.constraint(equalTo: tempView.trailingAnchor).isActive = true
        tempResultLabel.centerXAnchor.constraint(equalTo: tempView.centerXAnchor).isActive = true
        tempResultLabel.bottomAnchor.constraint(equalTo: tempView.bottomAnchor, constant: -3).isActive = true
        
        dustResultLabel.leadingAnchor.constraint(equalTo: dustView.leadingAnchor).isActive = true
        dustResultLabel.trailingAnchor.constraint(equalTo: dustView.trailingAnchor).isActive = true
        dustResultLabel.centerXAnchor.constraint(equalTo: dustView.centerXAnchor).isActive = true
        dustResultLabel.bottomAnchor.constraint(equalTo: dustView.bottomAnchor, constant: -3).isActive = true
        
    }
    
}

extension UIView {
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}

