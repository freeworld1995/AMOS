//
//  CustomDatePicker.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

protocol datePickerDelegate: class {
    func cancel()
    func send(date: String)
}

class CustomDatePicker: UIView {
    
    weak var delegate: datePickerDelegate?
    var selectedValue: String?
    
    var data: [String] = {
        return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    }()
    
    @IBOutlet weak var datePicker: UIPickerView!
    
    override func awakeFromNib() {
        datePicker.dataSource = self
        datePicker.delegate = self
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        delegate?.cancel()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard selectedValue != nil else { return }
        delegate?.send(date: selectedValue!)
    }
}

extension CustomDatePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = data[row]
    }
}
