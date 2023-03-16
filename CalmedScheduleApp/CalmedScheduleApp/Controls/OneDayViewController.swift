//
//  OneDayViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/10.
//

import UIKit

final class OneDayViewController: UIViewController, UITableViewDelegate {
    
    private let colorHelper = ColorHelper()
    lazy var tableView = UITableView()
    let toDoManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorHelper.backgroundColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("뷰 나타날 것")
        tableView.reloadData()
        setupTableView()
        setupNaviBar()
    }
    
    

    // MARK: - set NaviBar
    func setupNaviBar() {
        self.title = "Today"
        
        // 네비게이션바 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = colorHelper.backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: colorHelper.fontColor]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Bar 버튼 추가
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
        
        let delete = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(deleteTapped))
        navigationItem.leftBarButtonItem = delete
    }
    
    // MARK: - set TableView()
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = colorHelper.backgroundColor
        tableView.rowHeight = 120
        tableView.layer.cornerRadius = 5
        setupTableViewConstraints()
        // 셀의 등록과정
        tableView.register(TodayTableViewCell.self, forCellReuseIdentifier: "TodoCell")
    
    }
    
    // MARK: - TableView Autolayout
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func addTapped() {
        print("add button tapped")
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func deleteTapped() {
        print("delete button tapped")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("뷰 사라짐")
    }
    
    
    // MARK: - set Alert
    
    
}


extension OneDayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return toDoManager.getToDoListFromCoreData().count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodayTableViewCell
        
        let toDoData = toDoManager.getToDoListFromCoreData()
        cell.toDoData = toDoData[indexPath.row]
        
        cell.layer.borderColor = colorHelper.backgroundColor.cgColor
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        cell.doneButton.tag = indexPath.row
        cell.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)

        
        
        return cell
    }
    
    @objc func doneButtonPressed(_ target: UIButton) {
        print("\(target.tag)st done button pressed")
        func unpressedButtonSetting() {
            target.backgroundColor = self.colorHelper.buttonColor
            target.layer.shadowColor = UIColor.black.cgColor
            target.layer.shadowOpacity = 0.7
        }
        let targetTodo = toDoManager.getToDoListFromCoreData()[target.tag]
        var todoStatus = toDoManager.getToDoListFromCoreData()[target.tag].done

        // 버튼 색 및 그림자 변화
        target.layer.shadowOpacity = 0
        target.layer.shadowColor = .none
        target.backgroundColor = .gray
        // 얼럿창 생성
        let alert = UIAlertController(title: "일정 완료", message: "일정을 완료 하시겠습니까? \n (경고: 완료 된 일정은 목록에서 삭제됩니다.)", preferredStyle: .alert)
        // 얼럿창에 들어갈 액션 선택지 생성
        let success = UIAlertAction(title: "예", style: .default) { action in
            print("'예'버튼이 눌렸습니다.")
            deleteTodo()
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
        
        func deleteTodo() {
            todoStatus = true
            if todoStatus == true {
                toDoManager.deleteToDo(data: targetTodo) {
                    print("데이터 삭제됨")
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    
    
}
    

extension ViewController: UITableViewDelegate {
    
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)번째 셀이 선택됨")
//        // 다음화면으로 이동
//        let detailVC = DetailViewController()
//        let data = toDoManager.getToDoListFromCoreData()
//        detailVC.todoArray = data[indexPath]
//        show(detailVC, sender: nil)
//
//
//        navigationController?.present(editVC, animated: true)
    }
    
}
