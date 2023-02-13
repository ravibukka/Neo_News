//
//  ViewController.swift
//  NeoStats
//
//  Created by Ravi on 12/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    var startDate = Date()
    var endDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.isEnabled = false
        
        self.startDateTextField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateStartSelected))
        
        self.endDateTextField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateEndSelected))
        
    }
    
    @objc func dateStartSelected() {
        if let datePicker = self.startDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            startDate = datePicker.date
            self.startDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.startDateTextField.resignFirstResponder()
    }
    
    @objc func dateEndSelected() {
        if let datePicker = self.endDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            endDate = datePicker.date
            self.endDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.endDateTextField.resignFirstResponder()
        submitButton.isEnabled = ![startDateTextField, endDateTextField].compactMap {
            $0.text?.isEmpty
        }.contains(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "InputVCToDetailsVC"){
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.startDateRecieved = startDate
            detailsVC.endDateRecieved = endDate
        }
    }
}

extension DateComponents {
    
    func dateComponentsToTimeString() -> String {
        
        var hour = "\(self.hour!)"
        var minute = "\(self.minute!)"
        var second = "\(self.second!)"
        
        if self.hour! < 10 { hour = "0" + hour }
        if self.minute! < 10 { minute = "0" + minute }
        if self.second! < 10 { second = "0" + second }
        
        let str = "\(hour):\(minute):\(second)"
        return str
    }
    
}

extension Date {
    
    func offset(from date: Date)-> DateComponents {
        let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: date, to: self)
        return differenceOfDate
    }
}

extension Date {
    static func changeDaysBy(days : Int) -> Date {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.day = days
        return Calendar.current.date(byAdding: dateComponents, to: currentDate)!
    }
}

extension UITextField {
    
    func setDatePickerAsInputViewFor(target:Any, selector:Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 216.0))
        datePicker.datePickerMode = .date
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        toolBar.setItems([cancel,flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
