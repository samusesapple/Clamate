//
//  DetailViewController.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/15.
//

import UIKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    
    var todoArray: ArraySlice<TodoData> = []
    
    
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    


}
