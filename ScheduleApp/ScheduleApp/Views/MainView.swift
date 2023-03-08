//
//  MainView.swift
//  ScheduleApp
//
//  Created by Sam Sung on 2023/03/08.
//

import UIKit

class MainView: UIView {
    
    var greetingLabel: UILabel = {
       var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "현관님, \n오늘도 화이팅 하세요!"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "오늘은 2023년 3월 8일 입니다."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weatherLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .right
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "오늘의 기온은 영하 1도 입니다."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    var weatherImage: UIImageView = {
        var img = UIImageView()
        img.image = UIImage(systemName: "photo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    // MARK: - StackView
    lazy var infoStack: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [dateLabel, weatherLabel])
        stView.spacing = customSpacingAnchor
        stView.axis = .vertical
        stView.alignment = .fill
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
   
    
    // MARK: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - set Auto-layout
    private var customCornerAnchor: CGFloat = 20
    private var customSpacingAnchor: CGFloat = 15
    
    func setAutolayout() {
        //mainView autolayout
        self.addSubview(greetingLabel)
        greetingLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        greetingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customCornerAnchor).isActive = true
        greetingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: customCornerAnchor).isActive = true
        
        self.addSubview(infoStack)
        infoStack.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: customCornerAnchor).isActive = true
        infoStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: customCornerAnchor).isActive = true
        infoStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customCornerAnchor).isActive = true
        
        
        self.addSubview(weatherImage)
        weatherImage.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: customSpacingAnchor).isActive = true
        weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -customCornerAnchor).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
