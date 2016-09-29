//
//  AddTreatmentViewController.swift
//  TestCoreDataLayer
//
//  Created by Gene Backlin on 9/21/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit

class AddTreatmentViewController: UIViewController {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var levelTextField: UITextField!
    @IBOutlet weak var realLevelTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var delegate: MasterTableViewController?
    var dateTime: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.dateTime = Date()
//        self.dateTimeLabel.text = self.dataDateTime(self.dateTime)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTreatment(_ sender: AnyObject) {
        var treatments: [String : AnyObject] = [String : AnyObject]()
        treatments["dateTime"] = dateTime as AnyObject
        treatments["level"] = Int(levelTextField.text!) as AnyObject
        treatments["realLevel"] = Double(realLevelTextField.text!) as AnyObject
        treatments["duration"] = Int(durationTextField.text!) as AnyObject
        
        _ = self.navigationController?.popViewController(animated: true)
        self.delegate!.save(sender: treatments)
    }
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateTime = sender.date
        
        dateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Utility
    
    func dataDateTime(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd|hh:mm a"
        
        return dateFormatter.string(from: date!)
    }

}
