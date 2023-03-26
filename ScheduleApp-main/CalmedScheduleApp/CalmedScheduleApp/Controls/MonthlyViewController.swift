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

    private func setupNaviBar() {
        self.navigationItem.title = "Monthly"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  
        appearance.backgroundColor = colorHelper.backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: colorHelper.fontColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: colorHelper.fontColor]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = colorHelper.fontColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
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
    
    @objc private func addTapped() {
        let selection = UICalendarSelectionSingleDate(delegate: self)
        let addVC = AddViewController()
        if selection.selectedDate?.date != nil {
            addVC.selectedDate = selection.selectedDate!.date!
            navigationController?.pushViewController(addVC, animated: true)
        } else {
            navigationController?.pushViewController(addVC, animated: true)
        }
    }
    
    
}

extension MonthlyViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        guard let date = NSCalendar.current.date(from: dateComponents) else {
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
            return
        }
        
        if toDoManager.getCertainDateToDo(date: date).isEmpty != true {
            let selectAlert = UIAlertController(title: "일정", message: "해당 날짜의 일정이 존재합니다.", preferredStyle: .actionSheet)
            
            let add = UIAlertAction(title: "일정 추가", style: .default) {  [weak self] action in
                let addVC = AddViewController()
                addVC.selectedDate = dateComponents!.date
                self?.navigationController?.pushViewController(addVC, animated: true)
            }
            let check = UIAlertAction(title: "일정 확인", style: .default) {  [weak self] action in
                let certainDayVC = CertainDayViewController()
                certainDayVC.baseDate = date
                self?.navigationController?.pushViewController(certainDayVC, animated: true)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            }
            
            selectAlert.addAction(check)
            selectAlert.addAction(add)
            selectAlert.addAction(cancel)
            self.present(selectAlert, animated: true, completion: nil)
            return
        }
        else {
            let emptySchedule = UIAlertController(title: "빈 일정", message: "해당 날짜의 일정이 없습니다.", preferredStyle: .actionSheet)
            
            let add = UIAlertAction(title: "일정 추가", style: .default) {  [weak self] action in
                let addVC = AddViewController()
                addVC.selectedDate = dateComponents!.date
                
                self?.navigationController?.pushViewController(addVC, animated: true)
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel) {  action in
            }
            emptySchedule.addAction(cancel)
            emptySchedule.addAction(add)
            present(emptySchedule, animated: true, completion: nil)
            
            return
        }
    }
    
}
