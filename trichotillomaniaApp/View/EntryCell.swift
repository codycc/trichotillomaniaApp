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
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var intensityLbl: UILabel!
    @IBOutlet weak var didYouDigestLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(entry: Entry) {
        situationLabel.text = entry.situation
        lengthOfTimeLbl.text = String("\(entry.howLong) minutes")
        numberOfHairsLabel.text = String(entry.numberOfHairsPulled)
        areaLbl.text = entry.areaAffected
        if entry.didYouDigest == true {
            didYouDigestLbl.text = "Yes"
        } else {
            didYouDigestLbl.text = "No"
        }
        
        
        let date = NSDate(timeIntervalSince1970: entry.dateTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let finalDate = formatter.string(from: date as Date)
        let finalTime = timeFormatter.string(from: date as Date)
        timeLbl.text = String(describing: finalTime)
        dateLbl.text = String(describing: finalDate)
        
        
        
        intensityLbl.text = String(entry.intensity)
        
        
    }
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
