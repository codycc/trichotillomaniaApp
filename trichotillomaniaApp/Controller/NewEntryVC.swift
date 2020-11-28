//
//  NewEntryVC.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit
import CoreData

class NewEntryVC: UIViewController,UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var informationIntensity = Information()
    var informationDateTime = Information()
    var informationSituation = Information()
    var informationHowLong = Information()
    var informationNumOfHair = Information()
    var informationAffectedAreas = Information()
    
    var informationArray = [Information]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backTap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        tap.cancelsTouchesInView = false
        
        
        view.addGestureRecognizer(tap)
        backBtn.addGestureRecognizer(backTap)
        
        self.addInformationToArray()
        
    }
    
    func addInformationToArray() {
        informationIntensity.placeholder = "07"
        informationIntensity.label = "Intensity:"
        informationDateTime.placeholder = "Nov 12, 2020"
        informationDateTime.label = "Date/Time:"
        informationSituation.placeholder = "WorkDesk:"
        informationSituation.label = "Situation:"
        informationHowLong.placeholder = "50"
        informationHowLong.label = "How Long(Minutes):"
        informationNumOfHair.placeholder = "13"
        informationNumOfHair.label = "# of hairs:"
        informationAffectedAreas.placeholder = "Scalp"
        informationAffectedAreas.label = "Affected areas:"
        informationArray.append(informationIntensity)
        informationArray.append(informationDateTime)
        informationArray.append(informationSituation)
        informationArray.append(informationHowLong)
        informationArray.append(informationNumOfHair)
        informationArray.append(informationAffectedAreas)
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return informationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
        let information = informationArray[indexPath.row]
        cell.configureCell(info: information)
        return cell 
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
        let newEntry = Entry(context: context)

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
