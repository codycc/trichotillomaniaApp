//
//  NewEntryVC.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit
import CoreData

class NewEntryVC: UIViewController,UITextFieldDelegate{
  
    @IBOutlet weak var intensityTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var situationTextField: UITextField!
    @IBOutlet weak var howLongTextField: UITextField!
    @IBOutlet weak var numberOfHairsTextField: UITextField!
    @IBOutlet weak var affectedAreasTextField: UITextField!
    @IBOutlet weak var didYouDiegestControl: UISegmentedControl!
    @IBOutlet weak var backBtn: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backTap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        
        view.addGestureRecognizer(tap)
        backBtn.addGestureRecognizer(backTap)
        
        addPlaceholders()
        
        
    }
    
    func addPlaceholders() {
        intensityTextField.attributedPlaceholder = NSAttributedString(string: "7", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        dateTimeTextField.attributedPlaceholder = NSAttributedString(string: "Nov 12,2020", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        situationTextField.attributedPlaceholder = NSAttributedString(string: "Workdesk", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        howLongTextField.attributedPlaceholder = NSAttributedString(string: "20", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        numberOfHairsTextField.attributedPlaceholder = NSAttributedString(string: "12", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        affectedAreasTextField.attributedPlaceholder = NSAttributedString(string: "Scalp", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 200)
    }
    
    
    
    @objc func backTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createItem() {
        var newEntry = Entry(context: context)
        
        print(newEntry.situation!)
    }
    
    func saveItem() {
        do {
            try context.save()
        } catch {
           print("error saving context")
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        createItem()
    }
    
    

}
