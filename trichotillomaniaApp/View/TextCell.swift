//
//  TextCell.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-28.
//

import UIKit

class TextCell: UICollectionViewCell {
    
    @IBOutlet weak var entryLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    func configureCell(info: Information) {
        entryLbl.text = info.label
        textField.attributedPlaceholder = NSAttributedString(string:info.placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}
