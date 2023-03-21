//
//  TenDayView.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/17.
//

import UIKit

final class MonthlyView: UIView {
    let colorHelper = ColorHelper()
    
    var calendarView: UICalendarView = {
       let cal = UICalendarView()
        cal.backgroundColor = ColorHelper().backgroundColor
        cal.tintColor = ColorHelper().fontColor
        cal.timeZone = .autoupdatingCurrent
        cal.calendar = Calendar(identifier: .gregorian)
        cal.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        cal.locale = .current
        return cal
    }()
    
    lazy var totalScheduleView: UIView = {
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
    
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configureUI
    func configureUI() {
        self.backgroundColor = colorHelper.backgroundColor
        addSubview(calendarView)
        addSubview(totalScheduleView)
        setConstriaints()
    }
    
    
    // MARK: - set Constraints
    
    func setConstriaints() {
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        totalScheduleView.translatesAutoresizingMaskIntoConstraints = false
        totalScheduleView.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor).isActive = true
        totalScheduleView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor).isActive = true
        totalScheduleView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 20).isActive = true
        totalScheduleView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
    }
    


}
