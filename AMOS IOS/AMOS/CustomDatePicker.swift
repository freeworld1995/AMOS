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
    func timeGroup(value: String)
    func timeOnOff(value: String)
    func day(value: String)
}

enum PickerType {
    case timeGroup
    case timeOnOff
    case day
}

class CustomDatePicker: UIView {
    
    var pickerType: PickerType = .timeGroup
    
    weak var delegate: datePickerDelegate?
    var selectedValue = ""
    
    lazy var hourArr: [String] = {
        var array = [String]()
        for i in 1...24 {
            array.append("\(i)")
        }
        
        return array
    }()
    
    lazy var dayArr: [String] = {
        return [
            "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "Chủ nhật"
        ]
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
extension CustomDatePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case .timeGroup:
            return group.count
        case .timeOnOff:
            return hourArr.count
        case .day:
            return dayArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerType {
        case .timeGroup:
            return group[row]
        case .timeOnOff:
            return hourArr[row]
        case .day:
            return dayArr[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerType {
        case .timeGroup:
            delegate?.timeGroup(value: group[row])
        case .timeOnOff:
            delegate?.timeOnOff(value: hourArr[row])
        case .day:
            delegate?.day(value: "\(row + 1)")
        }
    }
}

// MARK: Methods
extension CustomDatePicker {
    func setupPicker(type: PickerType) {
        pickerType = type
        datePicker.reloadAllComponents()
    }
}
