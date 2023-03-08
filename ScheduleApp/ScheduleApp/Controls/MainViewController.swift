//
//  ViewController.swift
//  ScheduleApp
//
//  Created by Sam Sung on 2023/03/08.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    
    //view 교체
    override func loadView() {
        view = mainView
    }

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBarUI()
    }
    
    func setNaviBarUI() {
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // 투명으로
        
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = ""
        
    }


}

