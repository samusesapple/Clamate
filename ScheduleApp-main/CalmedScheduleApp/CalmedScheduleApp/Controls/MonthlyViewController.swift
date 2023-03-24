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
        self.tabBarController?.tabBar.isHidden = false
        setCalendar()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("calendar 나타남")
    }
    
    // MARK: - set NaviBar
    private func setupNaviBar() {
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
    }
    
    private func setCalendar() {
        monthlyView.setConstriaints()
        monthlyView.calendarView.delegate = self
        monthlyView.calendarView.visibleDateComponents = NSCalendar.current.dateComponents(in: .current, from: Date())
        let selection = UICalendarSelectionSingleDate(delegate: self)
        monthlyView.calendarView.selectionBehavior = selection
    }
    
    // MARK: - @objc func
    @objc private func addTapped() {
        print("add Button Tapped")
        let selection = UICalendarSelectionSingleDate(delegate: self)
        let addVC = AddViewController()
        if selection.selectedDate?.date != nil {
            addVC.selectedDate = selection.selectedDate!.date!
            print("선택된 날짜로 지정된 + view ")
            navigationController?.pushViewController(addVC, animated: true)
        } else {
            navigationController?.pushViewController(addVC, animated: true)
            print("기본 + view")
        }
    }
    
    
}
// MARK: - Extension
extension MonthlyViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        guard let date = NSCalendar.current.date(from: dateComponents) else {
            print("날짜 바인딩 도중 에러 발생")
            return nil
        }
        
        if toDoManager.getNotFinishedDateToDo(date: date).isEmpty != true  {
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
            let selectAlert = UIAlertController(title: "일정", message: "해당 날짜의 일정이 존재합니다.", preferredStyle: .actionSheet)
            
            let add = UIAlertAction(title: "일정 추가", style: .default) {  [weak self] action in
                let addVC = AddViewController()
                addVC.selectedDate = dateComponents!.date
                self?.navigationController?.pushViewController(addVC, animated: true)
                print("일정 추가")
            }
            let check = UIAlertAction(title: "일정 확인", style: .default) {  [weak self] action in
                print("일정 확인")
                let oneDayVC = OneDayViewController()
                oneDayVC.baseDate = date
//                oneDayVC.navigationItem.title = "List"
                self?.navigationController?.pushViewController(oneDayVC, animated: true)
            }
            let cancel = UIAlertAction(title: "돌아가기", style: .cancel) { action in
                print("일정확인 Cancel")
            }
            
            selectAlert.addAction(check)
            selectAlert.addAction(add)
            selectAlert.addAction(cancel)
            // 일정 없음 얼럿 띄우기
            self.present(selectAlert, animated: true, completion: nil)
            return
        }
        else {
            // 일정 없음 얼럿 생성
            let emptySchedule = UIAlertController(title: "빈 일정", message: "해당 날짜의 일정이 없습니다.", preferredStyle: .actionSheet)
            
            let add = UIAlertAction(title: "일정 추가", style: .default) {  [weak self] action in
                print("추가하기")
                let addVC = AddViewController()
                addVC.selectedDate = dateComponents!.date
                
                self?.navigationController?.pushViewController(addVC, animated: true)
            }
            
            let cancel = UIAlertAction(title: "돌아가기", style: .cancel) {  action in
                print("Cancel")
            }
            emptySchedule.addAction(cancel)
            emptySchedule.addAction(add)
            // 일정 없음 얼럿 띄우기
            present(emptySchedule, animated: true, completion: nil)
            
            return
        }
    }
    
}
