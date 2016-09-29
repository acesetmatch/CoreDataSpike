//
//  MasterTableViewController.swift
//  TestCoreDataLayer
//
//  Created by Gene Backlin on 9/21/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreDataLayer

class MasterTableViewController: UITableViewController {    
    var treatments: [String : PatientTreatment]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        //Date range test
        let currentDate: NSDate = NSDate()
        let daysToAdd = -14
        let calculatedDate = NSCalendar.current.date(byAdding: Calendar.Component.day, value: daysToAdd, to: currentDate as Date)
        let patientTreatments: [PatientTreatment]?  = CoreDataLayer.sharedInstance.getPatientTreatmentsForDateRange(startDate: calculatedDate! as Date, endDate: currentDate as Date)
        print("The patient treatments are: \(patientTreatments)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.treatments = CoreDataLayer.sharedInstance.getPatientTreatments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(_ sender: AnyObject) {
        performSegue(withIdentifier: "addTreatment", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataLayer.sharedInstance.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TreatmentHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TreatmentHistoryTableViewCell
        let treatment: PatientTreatment = CoreDataLayer.sharedInstance.getPatientTreatmentForIndex(index: indexPath.row)!
        let dateTime: [String] = self.dataDateTime(treatment.dateTime as Date?).characters.split{$0 == "|"}.map(String.init)
        
        // Configure the cell...
        
        cell.dateLabel.text = dateTime[0]
        cell.timeLabel.text = dateTime[1]
        cell.levelLabel.text = "\(treatment.level)"
        cell.durationLabel.text = "\(treatment.duration)"

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTreatment" {
            let controller: AddTreatmentViewController = segue.destination as! AddTreatmentViewController
            controller.delegate = self
        }
    }

    // MARK: - Delegate methods
    
    func save(sender: [String : AnyObject]) {
        CoreDataLayer.sharedInstance.savePatientTreatment(patientTreatment: sender)
        self.tableView.reloadData()
    }

    // MARK: - Utility
    
    open func dataDateTime(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd|hh:mm a"
        
        return dateFormatter.string(from: date!)
    }
    
}
