//
//  TodayTableViewCell.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/10.
//

import UIKit

final class TodayTableViewCell: UITableViewCell {
    
    private let colorHelper = ColorHelper()

    
    // MARK: - UI 구현
    
    lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.text = "PM 23:30"
        label.textColor = colorHelper.fontColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var todoMainLabel: UILabel = {
        let label = UILabel()
         label.text = "일정의 제목이 표시 됩니다."
         label.textColor = colorHelper.fontColor
         label.textAlignment = .left
         label.font = UIFont.systemFont(ofSize: 16)
         label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
         return label
     }()
    
    lazy var labelView: UIView = {
        let view = UIView()
        view.backgroundColor = colorHelper.buttonColor
        view.addSubview(timeLabel)
        view.addSubview(todoMainLabel)
        return view
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = colorHelper.buttonColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textColor = colorHelper.fontColor
        button.titleLabel?.textAlignment = .center
        
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 2.5
        return button
    }()
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    
    // MARK: - initializer
    // 생성 시점에 뷰 위에 객체들 올리기
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = colorHelper.buttonColor
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowRadius = 1.5
        
        contentView.addSubview(labelView)
        contentView.addSubview(editButton)
        
        labelViewAutolayout()
        timeLabelAutolayout()
        mainLabelAutolayout()
        buttonAutolayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - set Autolayout
    let customLeadingAnchor: CGFloat = 16
    let customSpacing: CGFloat = 11
    
    func labelViewAutolayout() {
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: customLeadingAnchor).isActive = true
        labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -customLeadingAnchor).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: 49).isActive = true
    }
    
    func timeLabelAutolayout() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 0).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 0).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }
    
    func mainLabelAutolayout() {
        todoMainLabel.translatesAutoresizingMaskIntoConstraints = false
        todoMainLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: customSpacing).isActive = true
        todoMainLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 0).isActive = true
    }
    
    func buttonAutolayout() {
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 57).isActive = true
    }
    
    
}
