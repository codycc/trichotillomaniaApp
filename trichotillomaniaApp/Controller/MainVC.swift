//
//  ViewController.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIImageView!
    
    var entry = Entry()
    var entryArray = [Entry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addTapped(_:)))
        addBtn.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryCell
        
        let entry = entryArray[indexPath.row]
        
        cell.configureCell(entry: entry)
        
        return cell
    }
    
    @objc func addTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.performSegue(withIdentifier: "goToAddEntryVC", sender: nil)
    }


}

