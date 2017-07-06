//
//  CustomDatePicker.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

protocol datePickerDelegate2: class {
    func cancel()
    func send(date: String)
}

enum PickerType2 {
    case onlyHourMinute
    case groupHourMinuteDay
    case hourMinuteDay
}

class CustomDatePicker2: UIView {
    
    var pickerType: PickerType2 = .onlyHourMinute
    
    weak var delegate: datePickerDelegate2?
    var selectedValue = ""
    
    lazy var hourArr: [String] = {
        var array = [String]()
        for i in 1...24 {
            array.append("\(i)")
        }
        
        return array
    }()
    
    lazy var dayArr: [String] = {
        var array = [String]()
        for i in 1...7 {
            array.append("\(i)")
        }
        
        return array
    }()
    
    lazy var group: [String] = {
        return ["1", "2", "3", "4"]
    }()
    
    @IBOutlet weak var datePicker: UIPickerView!
    var hasDay = false
    
    override func awakeFromNib() {
        datePicker.dataSource = self
        datePicker.delegate = self
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        delegate?.cancel()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard !selectedValue.isEmpty else { return }
        delegate?.send(date: selectedValue)
    }
}

// MARK: Datasource, delegate
extension CustomDatePicker2: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerType {
        case .onlyHourMinute:
            return 2
        case .hourMinuteDay:
            return 3
        case .groupHourMinuteDay:
            return 4
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case .onlyHourMinute:
            return hourArr.count
        case .hourMinuteDay:
            if component == 2 {
                return dayArr.count
            } else {
                return hourArr.count
            }
        case .groupHourMinuteDay:
            if component == 0 {
                return group.count
            } else if component == 3 {
                return dayArr.count
            } else {
                return hourArr.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerType {
        case .onlyHourMinute:
            return hourArr[row]
        case .hourMinuteDay:
            if component == 2 {
                return dayArr[row]
            } else {
                return hourArr[row]
            }
        case .groupHourMinuteDay:
            if component == 0 {
                return group[row]
            } else if component == 3 {
                return dayArr[row]
            } else {
                return hourArr[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerType {
        case .onlyHourMinute:
            selectedValue += hourArr[row]
        case .hourMinuteDay:
            let value1 = hourArr[pickerView.selectedRow(inComponent: 0)]
            let value2 = hourArr[pickerView.selectedRow(inComponent: 1)]
            let value3 = dayArr[pickerView.selectedRow(inComponent: 2)]
            selectedValue = "\(value1)\(value2)\(value3)"
        case .groupHourMinuteDay:
            let value1 = group[pickerView.selectedRow(inComponent: 0)]
            let value2 = hourArr[pickerView.selectedRow(inComponent: 1)]
            let value3 = hourArr[pickerView.selectedRow(inComponent: 2)]
            let value4 = dayArr[pickerView.selectedRow(inComponent: 3)]
            selectedValue = "\(value1)\(value2)\(value3)\(value4)"
        }
        
    }
}

// MARK: Methods
extension CustomDatePicker2 {
    func setupPicker(type: PickerType2) {
        pickerType = type
        datePicker.reloadAllComponents()
    }
}
