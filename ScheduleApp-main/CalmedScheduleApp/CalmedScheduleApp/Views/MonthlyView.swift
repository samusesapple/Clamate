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
        setConstriaints()
    }
    
    
    // MARK: - set Constraints
    
    func setConstriaints() {
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    


}
