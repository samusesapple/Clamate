//
//  CoreDataManager.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    private func certainDateString(date: Date?) -> String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let resultDate = date  else { return "" }
        let savedDateString = myFormatter.string(from: resultDate)
        return savedDateString
    }
    
    
    // 앱 델리게이트
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름 (코어데이터에 저장된 객체)
    private  let modelName: String = "TodoData"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getToDoListFromCoreData() -> [TodoData] {
        var toDoList: [TodoData] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "todoDate", ascending: true)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        
        return toDoList
    }
    
    
    // MARK: - [Read] 코어데이터에서 일치하는 날짜의 데이터 찾아서 불러오기
    func getCertainDateToDo(date: Date) -> [TodoData] {
        var toDoList: [TodoData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            let timeOrder = NSSortDescriptor(key: "todoTime", ascending: true)
            request.sortDescriptors = [timeOrder]
            
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return toDoList.filter { data in
            certainDateString(date: data.todoDate) == certainDateString(date: date)
        }
        
    }
    
    
    // MARK: - [Read] 코어데이터에서 done == true 인 데이터 찾아서 불러오기
    func getFinishedDateToDo(date: Date) -> [TodoData] {
        var toDoList: [TodoData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            let timeOrder = NSSortDescriptor(key: "todoTime", ascending: true)
            request.sortDescriptors = [timeOrder]
            
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return toDoList.filter { data in
            data.done == true
        }
        
    }
    
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveToDoData(todoDate: Date?, todoTime: Date?, todoTitle: String?, todoDetail: String?, todoDone: Bool,  completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                if let todoData = NSManagedObject(entity: entity, insertInto: context) as? TodoData {
                    
                    // MARK: - ToDoData에 실제 데이터 할당 ⭐️
                    todoData.todoDate = todoDate
                    todoData.todoTime = todoTime
                    todoData.todoTitle = todoTitle
                    todoData.todoDetailText = todoDetail
                    todoData.done = false
                    print("\(String(describing: todoData.todoDate)), \(String(describing: todoData.todoTime))")
                    
                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    

    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    func deleteToDo(data: TodoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = data.todoDate
        else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "todoDate = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetToDo = fetchedToDoList.first {
                        context.delete(targetToDo)
                        print("데이터 삭제됨")
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateToDo(newToDoData: TodoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newToDoData.todoDate else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "todoDate = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [TodoData] {
                    // 배열의 첫번째
                    if var targetToDo = fetchedToDoList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetToDo = newToDoData
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
}
