//
//  NewEntryVC.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit
import CoreData

class NewEntryVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
  
    
  
   
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var situationTextField: UITextField!
    @IBOutlet weak var howLongTextField: UITextField!
    @IBOutlet weak var numberOfHairsTextField: UITextField!
    @IBOutlet weak var affectedAreasTextField: UITextField!
    @IBOutlet weak var didYouDiegestControl: UISegmentedControl!
    @IBOutlet weak var intensityControl: UISlider!
    @IBOutlet weak var backBtn: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestSituation = NSFetchRequest<NSFetchRequestResult>(entityName: "Situation")
    var timeSince1970 = 0.0
    let situationPicker = UIPickerView()
    var situations = ["chair","home"]
    var selectedSituation: String = "hello"
    private var datePicker: UIDatePicker?
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backTap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        backBtn.addGestureRecognizer(backTap)
        
        
        createDatePicker()
        createSituationPicker()
        addPlaceholders()
       // fetchSituationData()
        
    }
    
    func createDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        dateTimeTextField.inputView = datePicker
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.addTarget(self, action: #selector(NewEntryVC.dateDoneClicked(datePicker:)), for: .valueChanged)
    }
    
    func createSituationPicker() {
        situationPicker.delegate = self
        situationTextField.inputView = situationPicker
    }
    
//    func fetchSituationData() {
//        situations = []
//        do {
//            let results = try context.fetch(requestSituation)
//            if results.count > 0 {
//                for result in results {
//                    situations.append(result as! Situation)
//                }
//            }
//           // selectedSituation = situations[0].place!
//        } catch {
//            // handle error
//        }
//    }
    
    @objc func dateDoneClicked(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        dateTimeTextField.text = dateFormatter.string(from: datePicker.date)
        timeSince1970 = self.datePicker!.date.timeIntervalSince1970
        print(timeSince1970)
//        let date = NSDate(timeIntervalSince1970: timeSince1970)
//        print(date)
    }
    
    func addPlaceholders() {
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
        newEntry.intensity = Int32(intensityControl.value)
        newEntry.situation = situationTextField.text!
        print(Int32(intensityControl.value))
        saveItem()
    }
    
    func saveItem() {
        do {
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
            self.dismiss(animated: true, completion: nil)
        } catch {
           print("error saving context")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return situations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSituation = situations[row]
        situationTextField.text = selectedSituation
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return situations.count
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        createItem()
    }
    
    

}
