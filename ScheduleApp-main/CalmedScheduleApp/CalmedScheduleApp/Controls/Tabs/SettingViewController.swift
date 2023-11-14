//
//  SettingViewController.swift
//  CalmedScheduleApp
//
//  Created by 성현관 on 11/14/23.
//

import UIKit

final class SettingViewController: UIViewController {

    private let settingView = SettingView()
    
    private let colorHelper = ColorHelper()
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
    }

    // MARK: - Helpers
    
    private func setupNaviBar() {
        self.navigationItem.title = CoreDataManager.shared.getUserInfoFromCoreData()?.userName
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = colorHelper.backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: colorHelper.fontColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: colorHelper.fontColor]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = colorHelper.fontColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
}
