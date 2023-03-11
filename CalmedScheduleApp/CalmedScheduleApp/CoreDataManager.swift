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
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "TodoData"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getToDoListFromCoreData() -> [TodoData] {
        var toDoList: [TodoData] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
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
    
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveToDoData(toDoTitle: String?, toDoDetail: String?, toDoTime: Int32, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? TodoData {
                    
                    // MARK: - ToDoData에 실제 데이터 할당 ⭐️
                    toDoData.todoTitle = toDoTitle
                    toDoData.todoDetailText = toDoDetail
                    toDoData.todoDate = Date()   // 날짜는 저장하는 순간의 날짜로 생성
                    toDoData.todoTime = toDoTime
                    
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
    
    
    
    
    
    
}
