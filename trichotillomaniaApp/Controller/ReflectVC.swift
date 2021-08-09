//
//  GoalVC.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-30.
//

import UIKit
import CoreData
import Charts

class ReflectVC: UIViewController  {
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var cycleBtn: UIImageView!
    
    var entriesArray = [Entry]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestEntry = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
    var selectedData = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let backTap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped(_:)))
        backBtn.addGestureRecognizer(backTap)
        let cycleTap = UITapGestureRecognizer(target: self, action: #selector(self.cycleTapped(_:)))
        cycleBtn.addGestureRecognizer(cycleTap)
        
        fetchEntries()
        updateChart()
       
    }
    
    func fetchEntries() {
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
    
    func updateChart(){
        //MAKE DECISION ON WHICH FUNCTION TO CALL
        switch selectedData {
        case 1:
            showArea()
            dataLbl.text = "Area Affected"
        case 2:
            showLength()
            dataLbl.text = "Length(Minutes)"
        case 3:
            showDigested()
            dataLbl.text = "Did You Digest?"
        case 4:
            showNumOfHairs()
            dataLbl.text = "Number Of Hairs"
        case 5:
            showSituation()
            dataLbl.text = "Situation"
        case 6:
            showIntensity()
            dataLbl.text = "Intensity"
        default:
            print("default")
            
        }
        
        ///
        pieChartView.chartDescription?.text = ""
        pieChartView.chartDescription?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pieChartView.legend.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pieChartView.animate(yAxisDuration: 1.0)
        pieChartView.notifyDataSetChanged()
    }
    
    
    func showSituation() {
        var counts: [String: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.situation!] = (counts[entry.situation!] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: entry.key)
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    
    func showIntensity() {
        var counts: [Int32: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.intensity] = (counts[entry.intensity] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: String(entry.key))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    func showLength() {
        var counts: [Int32: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.howLong] = (counts[entry.howLong] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: String(entry.key))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    func showDigested() {
        var counts: [String: Int32] = [:]
        var didYouDigest = ""
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in entriesArray {
            if entry.didYouDigest == true {
                didYouDigest = "Yes"
            } else {
                didYouDigest = "No"
            }
            
            counts[didYouDigest] = (counts[didYouDigest] ?? 0) + 1
        }

        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: entry.key)
            lineChartEntry.append(value)
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    func showNumOfHairs() {
        var counts: [Int32: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.numberOfHairsPulled] = (counts[entry.numberOfHairsPulled] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: String(entry.key))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
    }
    
    func showArea() {
        var counts: [String: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.areaAffected!] = (counts[entry.areaAffected!] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: String(entry.key))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
    }
    
    
    @objc func cycleTapped(_ sender: UITapGestureRecognizer? = nil) {
        selectedData += 1
        updateChart()
        if selectedData == 6 {
            selectedData = 0
        }
        
    }
    
    
    @objc func backTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
        

}
