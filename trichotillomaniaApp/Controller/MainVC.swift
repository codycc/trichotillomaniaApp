//
//  ViewController.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit
import CoreData
import CSV


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIImageView!
    @IBOutlet weak var goalBtn: UIImageView!
    @IBOutlet weak var sortBtn: UIImageView!
    @IBOutlet weak var sortLbl: UILabel!
    
    @IBOutlet weak var moreBtn: UIImageView!
    
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
        
        let moreTap = UITapGestureRecognizer(target: self, action: #selector(self.moreTapped(_:)))
        moreBtn.addGestureRecognizer(moreTap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
        grabEntries()
        sortDate()
    }
    
    func shareFiles() {
        
    }
    
   

    func savePDF() {
       
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
            sortLbl.text = "Hairs"
            entriesArray = entriesArray.sorted(by: { $0.numberOfHairsPulled < $1.numberOfHairsPulled })
            
        case 2:
            sortLbl.text = "Intensity"
            entriesArray = entriesArray.sorted(by: { $0.intensity < $1.intensity })
            
        case 3:
            sortLbl.text = "Time"
            entriesArray = entriesArray.sorted(by: { $0.howLong < $1.howLong })
            
        case 4:
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
    
    func createCSV() {
        let fileName =  "trichJournalLog1.csv"
        var csvText = "Date,# Of Hairs, length(minutes), Digested?, Area, Situation\n"
        
        for entry in entriesArray {
            let date = NSDate(timeIntervalSince1970: entry.dateTime)
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let finalDate = formatter.string(from: date as Date)
            let stringDate = String(describing: finalDate)
            
            let newLine = "\(stringDate),\(entry.numberOfHairsPulled),\(entry.howLong),\(entry.didYouDigest),\(entry.areaAffected!), \(entry.situation!)\n"
            csvText.append(newLine)
        }


            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

                let fileURL = dir.appendingPathComponent(fileName)

                do {
                    try csvText.write(to: fileURL, atomically: false, encoding: .utf8)
                    let doc = UIDocument(fileURL: fileURL)
                    let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                               self.present(activityViewController, animated: true, completion: nil)
                       // just send back the first one, which ought to be the only one
                       
                } catch {

                    print("\(error)")

                }
            }
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
    
    @objc func moreTapped(_ sender: UITapGestureRecognizer? = nil) {
        createCSV()
    }


}

