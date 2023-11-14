//
//  SettingView.swift
//  CalmedScheduleApp
//
//  Created by 성현관 on 11/14/23.
//

import UIKit

final class SettingView: UIView {

    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorHelper().backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
