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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestEntry = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
    
    var entriesArray = [Entry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addTapped(_:)))
        addBtn.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
        grabEntries()
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryCell
        
        let entry = entriesArray[indexPath.row]
        
        cell.configureCell(entry: entry)
        
        return cell
    }
    
    @objc func reloadTable() {
        print("called")
        grabEntries()
        tableView.reloadData()
    }
    
    @objc func addTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.performSegue(withIdentifier: "goToAddEntryVC", sender: nil)
    }


}

