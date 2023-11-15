//
//  CoreDataManager.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    private func certainDateString(date: Date?) -> String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let resultDate = date  else { return "" }
        let savedDateString = myFormatter.string(from: resultDate)
        return savedDateString
    }
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    private let userModelName: String = "UserData"
    private let todoModelName: String = "TodoData"

    
    func getUserInfoFromCoreData() -> UserData? {
        var userData: UserData?
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.userModelName)
            do {
                if let fetchedUserData = try context.fetch(request) as? [UserData] {
                    if !fetchedUserData.isEmpty {
                        userData = fetchedUserData[0]
                    } else {
                        userData = nil
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return userData
    }
    
    func saveUserData(userName: String?, userCity: String?, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.userModelName, in: context) {
                if let userData = NSManagedObject(entity: entity, insertInto: context) as? UserData {

                    userData.userName = userName
                    userData.userCity = userCity
                    
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
    
    func getToDoListFromCoreData() -> [TodoData] {
        var toDoList: [TodoData] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.todoModelName)
            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "todoDate", ascending: true)
            request.sortDescriptors = [dateOrder]
            
            do {
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return toDoList
    }
    
    
    //[Read] 코어데이터에서 일치하는 날짜의 데이터 찾아서 불러오기
    func getCertainDateToDo(date: Date) -> [TodoData] {
        var toDoList: [TodoData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.todoModelName)
            
            let timeOrder = NSSortDescriptor(key: "todoTime", ascending: true)
            request.sortDescriptors = [timeOrder]
            
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return toDoList.filter { data in
            certainDateString(date: data.todoDate) == certainDateString(date: date)
        }
        
    }
    
    
    //[Read] 코어데이터에서 done == true 인 데이터 찾아서 불러오기
    func getFinishedDateToDo(date: Date) -> [TodoData] {
        var toDoList: [TodoData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.todoModelName)
            
            let timeOrder = NSSortDescriptor(key: "todoTime", ascending: true)
            request.sortDescriptors = [timeOrder]
            
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return toDoList.filter { data in
            data.done == true
        }.filter { data in
            certainDateString(date: data.todoDate) == certainDateString(date: date)
        }
        
    }
    
    //[Read] 코어데이터에서 done == false 인 데이터 찾아서 불러오기
    func getNotFinishedDateToDo(date: Date) -> [TodoData] {
        var toDoList: [TodoData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.todoModelName)
            
            let timeOrder = NSSortDescriptor(key: "todoTime", ascending: true)
            request.sortDescriptors = [timeOrder]
            
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return toDoList.filter { data in
            data.done == false
        }.filter { data in
            certainDateString(date: data.todoDate) == certainDateString(date: date)
        }
        
    }
    
    
    func saveToDoData(todoDate: Date?, todoTime: Date?, todoTitle: String?, todoDetail: String?, todoDone: Bool,  completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.todoModelName, in: context) {
                
                if let todoData = NSManagedObject(entity: entity, insertInto: context) as? TodoData {

                    todoData.todoDate = todoDate
                    todoData.todoTime = todoTime
                    todoData.todoTitle = todoTitle
                    todoData.todoDetailText = todoDetail
                    todoData.done = false
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    func deleteToDo(data: TodoData, completion: @escaping () -> Void) {
        guard let date = data.todoDate
        else {
            completion()
            return
        }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.todoModelName)
            request.predicate = NSPredicate(format: "todoDate = %@", date as CVarArg)
            
            do {
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    
                    if let targetToDo = fetchedToDoList.first {
                        context.delete(targetToDo)
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                completion()
            }
        }
    }
    
    func updateToDo(newToDoData: TodoData, completion: @escaping () -> Void) {
        guard let date = newToDoData.todoDate else {
            completion()
            return
        }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.todoModelName)
            request.predicate = NSPredicate(format: "todoDate = %@", date as CVarArg)
            
            do {
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    // 배열의 첫번째
                    if var targetToDo = fetchedToDoList.first {
                        targetToDo = newToDoData
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                completion()
            }
        }
    }
    
    /// Notification Center에 등록할 데이터 가져오기
    func getDataToSetOnNotificationCenter() -> [TodoData] {
        let todoData = getToDoListFromCoreData()
        var filteredData: [TodoData] = []
        for data in todoData {
            guard let date = data.todoDate,
                  let time = data.todoTime,
                  let combinedDate = Date.combine(date: date, time: time),
                  combinedDate.timeIntervalSinceNow >= 0,
                  data.done == false else { continue } // 현재 시간 이후의 완료되지 않은 일정의 데이터만 받아오기
            filteredData.append(data)
        }
        print(filteredData.count)
        return filteredData
    }

    
}
