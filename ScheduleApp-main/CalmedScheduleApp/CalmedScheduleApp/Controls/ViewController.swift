//
//  ViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit

final class ViewController: UIViewController, UITabBarDelegate {
    private let colorHelper = ColorHelper()
    private var mainView = MainView()
    // 모델(저장 데이터를 관리하는 코어데이터)
    private let toDoManager = CoreDataManager.shared
    private let dustManager = DustManager.shared
    
    private var shortDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd (EEE)"
        let date = Date()
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    override func loadView() {
        view = mainView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        
    }
    
    
    // MARK: - set UI with Data
    func setUpData() {
        mainView.dateLabel.text = shortDateString
        
        dustManager.getTodayDust {
            DispatchQueue.main.async {
                self.mainView.dustResult = self.dustManager.dustResult
                self.loadViewIfNeeded()
            }
        }
        
    }
}
