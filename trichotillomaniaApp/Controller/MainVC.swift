//
//  ViewController.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIImageView!
    @IBOutlet weak var goalBtn: UIImageView!
    @IBOutlet weak var sortBtn: UIImageView!
    @IBOutlet weak var sortLbl: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestEntry = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
    
    var entriesArray = [Entry]()
    var currentSortId = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addTapped(_:)))
        addBtn.addGestureRecognizer(tap)
        let goalTap = UITapGestureRecognizer(target: self, action: #selector(self.goalTapped(_:)))
        goalBtn.addGestureRecognizer(goalTap)
        let sortTap = UITapGestureRecognizer(target: self, action: #selector(self.sortTapped(_:)))
        sortBtn.addGestureRecognizer(sortTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
        grabEntries()
        sortDate()
        // Do any additional setup after loading the view.
    }
    
    func grabEntries() {
        entriesArray = []
        do {
            let results = try context.fetch(requestEntry)
            if results.count > 0 {
                for result in results {
                    entriesArray.append(result as! Entry)
                }
            }
        } catch {
            // handle error
        }
    }
    //sort entries based on current sortIndex
    
    func sortEntries() {
       
        switch currentSortId {
        case 1:
            print("number of hairs")
            sortLbl.text = "Hairs"
            entriesArray = entriesArray.sorted(by: { $0.numberOfHairsPulled < $1.numberOfHairsPulled })
            
        case 2:
            
            print("intesntiy")
            sortLbl.text = "Intensity"
            entriesArray = entriesArray.sorted(by: { $0.intensity < $1.intensity })
            
        case 3:
            print("length of time")
            sortLbl.text = "Time"
            entriesArray = entriesArray.sorted(by: { $0.howLong < $1.howLong })
            
        case 4:
            
            print("date")
            sortLbl.text = "Date"
            entriesArray = entriesArray.sorted(by: { $0.dateTime < $1.dateTime })
            
            
        default:
            print("hello")
            
        }
        
    }
    func sortDate() {
        entriesArray = entriesArray.sorted(by: { $0.dateTime < $1.dateTime })
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
              entriesArray.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryCell
        
        let entry = entriesArray[indexPath.row]
        
        cell.configureCell(entry: entry)
        
        return cell
    }
    
    @objc func reloadTable() {
        grabEntries()
        currentSortId -= 1
        sortEntries()
        currentSortId += 1 
        tableView.reloadData()
    }
    
    @objc func addTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.performSegue(withIdentifier: "goToAddEntryVC", sender: nil)
    }
    
    @objc func sortTapped(_ sender: UITapGestureRecognizer? = nil) {
        if currentSortId == 5 {
            currentSortId = 1
        }
        sortEntries()
        tableView.reloadData()
        currentSortId += 1
    }
    
    @objc func goalTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.performSegue(withIdentifier: "goToReflectVC", sender: nil)
    }


}

