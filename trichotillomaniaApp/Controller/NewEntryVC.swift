//
//  NewEntryVC.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit

class NewEntryVC: UIViewController {

    @IBOutlet weak var intensityTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var situationTextField: UITextField!
    @IBOutlet weak var howLongTextField: UITextField!
   
    @IBOutlet weak var numberOfHairsTextField: UITextField!
    
    @IBOutlet weak var affectedAreasTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
    }
    
    

}
