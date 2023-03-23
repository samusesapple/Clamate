//
//  OneDayViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/10.
//

import UIKit

final class OneDayViewController: UIViewController {
    
    private let colorHelper = ColorHelper()
    lazy var tableView = UITableView()
    lazy var toDoManager = CoreDataManager.shared
    var baseDate: Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorHelper.backgroundColor
        setupTableView()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("뷰 나타날 것")
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    
    // MARK: - set NaviBar
    private func setupNaviBar() {
        // 네비게이션바 설정
        self.navigationItem.title = "Today"
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
    
    
    // MARK: - set TableView()
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 100
        tableView.layer.cornerRadius = 5
        setupTableViewConstraints()
        // 셀 등록
        tableView.register(TodayTableViewCell.self, forCellReuseIdentifier: "TodoCell")
    }
    
    // MARK: - TableView Autolayout
    private func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc private func addTapped() {
        print("add button tapped")
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("OneDayView 사라짐")
    }
    
    
}
// MARK: - Extension - UITableViewDataSource
extension OneDayViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return toDoManager.getNotFinishedDateToDo(date: baseDate).count
        case 1:
            return toDoManager.getFinishedDateToDo(date: baseDate).count
        default :
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "To Do List"
        case 1:
            return "Done List"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodayTableViewCell
        
        switch indexPath.section {
        case 0:
            let falseToDoData = toDoManager.getNotFinishedDateToDo(date: baseDate)
            cell.doneButton.setTitle("Done", for: .normal)
            cell.layer.borderColor = colorHelper.backgroundColor.cgColor
            cell.layer.borderWidth = 5
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            
            cell.doneButton.tag = indexPath.row
            cell.doneButton.addTarget(self, action: #selector(cellButtonPressed), for: .touchUpInside)
            
            cell.toDoData = falseToDoData[indexPath.row]
            
            return cell
            
        case 1:
            let trueToDoData = toDoManager.getFinishedDateToDo(date: baseDate)
            cell.doneButton.setTitle("Undo", for: .normal)
            cell.layer.borderColor = colorHelper.backgroundColor.cgColor
            cell.layer.borderWidth = 5
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
    
            cell.doneButton.tag = indexPath.row
            cell.doneButton.addTarget(self, action: #selector(cellButtonPressed), for: .touchUpInside)
            
            cell.toDoData = trueToDoData[indexPath.row]
            return cell
            
        default:
            return cell
        }
        
        
    }
    
    // MARK: - functions for addTarget
    @objc func cellButtonPressed(_ target: UIButton) {
        print("\(target.tag)st done button pressed")
        func unpressedButtonSetting() {
            target.backgroundColor = self.colorHelper.buttonColor
            target.layer.shadowColor = UIColor.black.cgColor
            target.layer.shadowOpacity = 0.3
        }
        
        // 버튼 색 및 그림자 변화
        target.layer.shadowOpacity = 0
        target.layer.shadowColor = .none
        target.backgroundColor = .gray
        // 얼럿창 생성
        let alert = UIAlertController(title: "일정을 완료 하시겠습니까?", message: "", preferredStyle: .actionSheet)
        if target.titleLabel?.text == "Undo" {
            alert.title = "일정의 상태를 변경 하시겠습니까?"
            alert.message = "'예'를 선택하여 미완료 상태로 변경합니다."
        }
        // 얼럿창의 액션 선택지 생성
        let success = UIAlertAction(title: "예", style: .default) { action in
            print("'예'버튼이 눌렸습니다.")
            changeTodoStatus()
            unpressedButtonSetting()
        }
        let cancel = UIAlertAction(title: "아니오", style: .cancel) { action in
            print("'아니오'버튼이 눌렸습니다.")
            unpressedButtonSetting()
        }
        alert.addAction(success)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        return
        
        func changeTodoStatus() {
            if target.titleLabel?.text == "Done" {
                let targetTodo = (toDoManager.getNotFinishedDateToDo(date: baseDate)[target.tag])
                targetTodo.done = true
                toDoManager.updateToDo(newToDoData: targetTodo) {
                    print("true로 변경 : \(targetTodo.done) ")
                    self.tableView.reloadData()
                    
                }
            } else {
                let targetTodo = (toDoManager.getFinishedDateToDo(date: baseDate)[target.tag])
                targetTodo.done = false
                toDoManager.updateToDo(newToDoData: targetTodo) {
                    print("false로 변경 : \(targetTodo.done) ")
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
    }
}

// MARK: - Extension - UITableViewDelegate
extension OneDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)번째 셀이 선택됨")
        let detailVC = DetailViewController()
        // 다음화면으로 이동
        switch indexPath.section {
        case 0:
            let data = toDoManager.getNotFinishedDateToDo(date: baseDate)
            detailVC.detailView.toDoData = data[indexPath.row]
            print(Date())
            navigationController?.navigationBar.isHidden = false
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(detailVC, animated: true)
        case 1:
            let data = toDoManager.getFinishedDateToDo(date: baseDate)
            detailVC.detailView.toDoData = data[indexPath.row]
            print(Date())
            navigationController?.navigationBar.isHidden = false
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(detailVC, animated: true)
        default:
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // 테이블뷰 swiping 액션 - 데이터 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { action, view, completionHandler in
            print("action performed")
            
            let alert = UIAlertController(title: "일정을 삭제 하시겠습니까?", message: "", preferredStyle: .alert)
            
            // 삭제 실행
            let yes = UIAlertAction(title: "예", style: .default) { action in
                print("삭제를 실행합니다")
                switch indexPath.section {
                case 0:
                    let data = self.toDoManager.getNotFinishedDateToDo(date: self.baseDate)
                    self.toDoManager.deleteToDo(data: data[indexPath.row]) {
                        tableView.reloadData()
                    }
                case 1:
                    let data = self.toDoManager.getFinishedDateToDo(date: self.baseDate)
                    self.toDoManager.deleteToDo(data: data[indexPath.row]) {
                        tableView.reloadData()
                    }
                default:
                    print("swiping delete failed")
                }
            }
            // 삭제 취소
            let no = UIAlertAction(title: "아니오", style: .cancel) { action in
                print("삭제를 취소합니다")
            }
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
            
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
