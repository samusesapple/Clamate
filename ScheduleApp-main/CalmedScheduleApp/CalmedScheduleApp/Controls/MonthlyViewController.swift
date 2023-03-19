//
//  TenDayViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/17.
//

import UIKit

final class MonthlyViewController: UIViewController {
    lazy var toDoManager = CoreDataManager.shared
    lazy var monthlyView = MonthlyView()
    private let colorHelper = ColorHelper()
    
    override func loadView() {
        view = monthlyView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setCalendar()
    }


    // MARK: - set NaviBar
    func setupNaviBar() {
        // 네비게이션바 설정
        self.navigationItem.title = "Monthly"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = colorHelper.backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: colorHelper.fontColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: colorHelper.fontColor]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = colorHelper.fontColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Bar 버튼 추가
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.leftBarButtonItem = refresh
    }

    
    @objc func addTapped() {
        print("add Button Tapped")
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func refreshTapped() {
        print("refresh Button Tapped")
        
    }
    
    
    func setCalendar() {
        monthlyView.setConstriaints()
        monthlyView.calendarView.delegate = self
        let selection = UICalendarSelectionSingleDate(delegate: self)
        monthlyView.calendarView.selectionBehavior = selection
    }
    
}
// MARK: - Extension
extension MonthlyViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {

        guard let date = NSCalendar.current.date(from: dateComponents) else {
            print("날짜 바인딩 도중 에러 발생")
            return nil
        }
        if toDoManager.getCertainDateToDo(date: date).isEmpty != true  {
        return UICalendarView.Decoration.default(color: colorHelper.cancelBackgroundColor, size: .large)
    }

    return nil
    }
}
                                    
                                    
extension MonthlyViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        
        guard let date = NSCalendar.current.date(from: dateComponents!) else {
            print("날짜 바인딩 도중 에러 발생")
            print(dateComponents!)
            return
        }
        
        if toDoManager.getCertainDateToDo(date: date).isEmpty != true {
            let oneDayVC = OneDayViewController()
            oneDayVC.baseDate = date
            present(oneDayVC, animated: true)
            
        }
        else {
            // 일정 없음 얼럿 생성
            let failureAlert = UIAlertController(title: "빈 일정", message: "해당 날짜에는 일정이 없습니다.", preferredStyle: .alert)
            
            let failure = UIAlertAction(title: "돌아가기", style: .cancel) { action in
                print("저장 실패")
            }
            failureAlert.addAction(failure)
            // 일정 없음 얼럿 띄우기
            self.present(failureAlert, animated: true, completion: nil)
            
            return
        }
        
    }
    
}
