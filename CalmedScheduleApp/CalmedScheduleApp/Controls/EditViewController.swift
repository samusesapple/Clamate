//
//  EditViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/11.
//

import UIKit

class EditViewController: UIViewController {

    let editView = EditView()
    
    override func loadView() {
        view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
