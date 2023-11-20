//
//  OneDayViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/10.
//

import UIKit

final class CertainDayViewController: UIViewController {
    
    private let colorHelper = ColorHelper()
    private var tableView = UITableView()
    private var toDoManager = CoreDataManager.shared
    var baseDate: Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorHelper.backgroundColor
        setupTableView()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupNaviBar() {
        navigationItem.title = DateHelper().veryShortDateString(date: baseDate)
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
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 100
        tableView.layer.cornerRadius = 5
        setupTableViewConstraints()
        
        tableView.register(TodayTableViewCell.self, forCellReuseIdentifier: "TodoCell")
    }
    
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
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    
}

extension CertainDayViewController: UITableViewDataSource {
    
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
    
    @objc func cellButtonPressed(_ target: UIButton) {
        func unpressedButtonSetting() {
            target.backgroundColor = colorHelper.buttonColor
            target.layer.shadowColor = UIColor.black.cgColor
            target.layer.shadowOpacity = 0.3
        }
        
        func changeTodoStatus() {
            if target.titleLabel?.text == "Done" {
                let targetTodo = (toDoManager.getNotFinishedDateToDo(date: baseDate)[target.tag])
                targetTodo.done = true
                toDoManager.updateToDo(newToDoData: targetTodo) { [weak self] in
                    self?.tableView.reloadData()
                }
            } else {
                let targetTodo = (toDoManager.getFinishedDateToDo(date: baseDate)[target.tag])
                targetTodo.done = false
                toDoManager.updateToDo(newToDoData: targetTodo) { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
        
        target.layer.shadowOpacity = 0
        target.layer.shadowColor = .none
        target.backgroundColor = .gray
        
        unpressedButtonSetting()
        changeTodoStatus()
    }
    
    
}

extension CertainDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { [weak self] action, view, completionHandler in
            // 삭제 실행
            switch indexPath.section {
            case 0:
                let data = self?.toDoManager.getNotFinishedDateToDo(date: self!.baseDate)
                self?.toDoManager.deleteToDo(data: data![indexPath.row]) {
                    tableView.reloadData()
                }
            case 1:
                let data = self?.toDoManager.getFinishedDateToDo(date: self!.baseDate)
                self?.toDoManager.deleteToDo(data: data![indexPath.row]) {
                    tableView.reloadData()
                }
            default:
                break
            }
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
