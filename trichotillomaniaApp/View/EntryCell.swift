//
//  EntryCell.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit

class EntryCell: UITableViewCell {

    @IBOutlet weak var situationLabel: UILabel!
    @IBOutlet weak var lengthOfTimeLbl: UILabel!
    @IBOutlet weak var numberOfHairsLabel: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(entry: Entry) {
        situationLabel.text = entry.situation
        lengthOfTimeLbl.text = String(entry.lengthOfTime)
    }
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
