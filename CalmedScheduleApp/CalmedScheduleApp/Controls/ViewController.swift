//
//  ViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/09.
//

import UIKit

final class ViewController: UIViewController, UITabBarDelegate {
    let colorHelper = ColorHelper()
    var mainView = MainView()
    
    override func loadView() {
        view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - addTarget
    

    
    @objc func firstButtonTapped() {
        print("first button tapped")
    }
    @objc func secondButtonTapped() {
        print("second button tapped")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear 호출됨")
        
    }
}
