////
////  OneDayTableViewCell.swift
////  CalmedScheduleApp
////
////  Created by Sam Sung on 2023/03/11.
////
//
//import UIKit
//
//class OneDayTableViewCell: UITableViewCell {
//
//    
//    // MARK: - build UI
//    
//    var timeLabel: UILabel = {
//       let label = UILabel()
//        label.text = "PM 23:30"
//        label.textColor = ColorHelper().fontColor
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.backgroundColor = .clear
//        
//        return label
//    }()
//    
//    var titleLabel: UILabel = {
//        let label = UILabel()
//         label.text = "일정의 제목이 표시됩니다."
//         label.textColor = ColorHelper().fontColor
//         label.textAlignment = .left
//         label.font = UIFont.systemFont(ofSize: 16)
//         label.numberOfLines = 0
//         return label
//     }()
//    
//    var detailLabel: UILabel = {
//        let label = UILabel()
//         label.text = "사용자가 입력한 일정의 내용이 일부분 표시됩니다."
//         label.textColor = ColorHelper().fontColor
//         label.textAlignment = .left
//         label.font = UIFont.systemFont(ofSize: 16)
//        label.numberOfLines = 2
//        return label
//    }()
//    
//    let editButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Edit", for: .normal)
//        button.backgroundColor = ColorHelper().buttonColor
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.titleLabel?.textColor = ColorHelper().fontColor
//        button.titleLabel?.textAlignment = .center
//        
//        button.layer.cornerRadius = 5
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        button.layer.shadowOpacity = 0.7
//        button.layer.shadowRadius = 2.5
//        return button
//    }()
//    
//    
//    // MARK: - 각각의 stackView 생성
//    
//    let stackView: UIStackView = {
//        let sv = UIStackView()
//        sv.axis = .vertical
//        sv.spacing = 11
//        sv.distribution = .fillEqually
//        sv.alignment = .fill
//        return sv
//    }()
//    
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .default, reuseIdentifier: reuseIdentifier)
//        setupStackView()
//    }
//    
//    func setupStackView() {
//        
//        self.addSubview(mainImageView)
//        
//        // 뷰컨트롤러의 기본뷰 위에 스택뷰 올리기
//        self.addSubview(stackView)
//        
//        // 스택뷰 위에 뷰들 올리기
//        stackView.addArrangedSubview(timeLabel)
//        stackView.addArrangedSubview(titleLabel)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // 오토레이아웃 정하는 정확한 시점
//    override func updateConstraints() {
//        setConstraints()
//        super.updateConstraints()
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    
//}
