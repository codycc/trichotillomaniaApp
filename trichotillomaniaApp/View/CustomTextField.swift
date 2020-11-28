//
//  CustomTextField.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-28.
//

import Foundation
import UIKit


class CustomTextField: UITextField {
    
    override func awakeFromNib() {
            super.awakeFromNib()
            //Color
            layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3 ).cgColor
            // Opacity
            layer.shadowOpacity = 0.2
            // How far is spreads / blurs out
            layer.shadowRadius = 4.0
            // 1 down, 1 up
            layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
            layer.cornerRadius = 2.0
    }
    
}
