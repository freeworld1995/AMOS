//
//  testViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/7/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    @IBOutlet var textField_Date: UITextField!

//    @IBOutlet var datePicker: UIDatePicker!
    var datePicker : UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickUpDate(textField_Date)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker
        self.view.addSubview(datePicker)
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        textField_Date.text = dateFormatter1.string(from: datePicker.date)
        textField_Date.resignFirstResponder()
    }
    
    func cancelClick() {
        textField_Date.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUpDate(self.textField_Date)
    }
}
