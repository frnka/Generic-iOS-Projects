//
//  DatePickerViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 7/16/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    
    let datePicker1 = UIDatePicker()
    let datePicker2 = UIDatePicker()
    var theDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = Date()
        let oneDay = 24*60*60
        let minDate = currentDate.addingTimeInterval(TimeInterval(oneDay))
        datePicker1.minimumDate = minDate
        
        startDate.tag = 0
        endDate.tag = 1
        startDate.delegate = self
        endDate.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0{
            print("editing the start date")
            showDatePicker()
        }
        else{
            if startDate.text == nil{
                let alertController = UIAlertController(title: "Alert", message: "Set start date first", preferredStyle: .alert)
               
                let action2 = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction) in
                    print("You've pressed cancel");
                }
                
                
                
                alertController.addAction(action2)
           
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                datePicker2.minimumDate = theDate.addingTimeInterval(TimeInterval(30*60))
            
                print("editing the start date")
                showDatePicker2()
            }
        }
    }
    
    func showDatePicker(){
        //Formate Date
        
        datePicker1.datePickerMode = .dateAndTime
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donedatePicker1))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        startDate.inputAccessoryView = toolbar
        // add datepicker to textField
        startDate.inputView = datePicker1
        
    }
        func showDatePicker2(){
            //Formate Date
            
            datePicker2.datePickerMode = .dateAndTime
            
            //ToolBar
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            
            //done button & cancel button
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donedatePicker2))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(cancelDatePicker))
            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
            
            // add toolbar to textField
            endDate.inputAccessoryView = toolbar
            // add datepicker to textField
            endDate.inputView = datePicker2
            
        }
    @objc func donedatePicker1(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy h:mm a"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MMM"
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "d"
        
        let month = formatter2.string(from: datePicker1.date)
        let day = formatter3.string(from: datePicker1.date)
        print("month is \(month) and day is \(day)")
        
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "yyMMdd"
        let date = formatter4.string(from: datePicker1.date)
        print("date to write to the database is :\(date)")
        if let weekday = datePicker1.date.dayOfWeek(){
            startDate.text = weekday + " " + formatter.string(from: datePicker1.date)
        }
        else{
        startDate.text = formatter.string(from: datePicker1.date)
        }
        self.theDate = datePicker1.date
        
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    

    @objc func donedatePicker2(){
            //For date formate
            let formatter = DateFormatter()
           formatter.dateFormat = "M/d/yyyy h:mm a"
        
        if let weekday = datePicker2.date.dayOfWeek(){
            endDate.text = weekday + " " + formatter.string(from: datePicker2.date)
        }
        else{
            endDate.text = formatter.string(from: datePicker2.date)
        }
            //dismiss date picker dialog
            self.view.endEditing(true)
        }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}



