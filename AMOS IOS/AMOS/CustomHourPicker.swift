//
//  CustomHourPicker.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/7/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

//protocol CustomHourPickerDelegate: class {
//    func cancel()
//    func
//}

class CustomHourPicker: UIView {
    
    @IBOutlet weak var picker: UIPickerView!
    
    var selectedValue = ""
    
    lazy var hour: [String] = {
        var arr = [String]()
        
        for i in 0...23 {
            if i < 10 {
                arr.append("0\(i) H")
            } else {
                arr.append("\(i) H")
            }
        }
        return arr
    }()
    
    lazy var minute: [String] = {
        var arr = [String]()
        
        for i in 0...59 {
            if i < 10 {
                arr.append("0\(i) m")
            } else {
                arr.append("\(i) m")
            }
        }
        return arr
    }()
    
    lazy var second: [String] = {
        var arr = [String]()
        
        for i in 0...59 {
            if i < 10 {
                arr.append("0\(i) s")
            } else {
                arr.append("\(i) s")
            }
        }
        return arr
    }()
    
    var hourMinuteSecondArr = [[String]]()
    
    override func awakeFromNib() {
        picker.dataSource = self
        picker.delegate = self
        
        hourMinuteSecondArr = [hour, minute, second]
    }
}

// MARK: Datasource, delegate
extension CustomHourPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hourMinuteSecondArr[component].count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hourMinuteSecondArr[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hour = hourMinuteSecondArr[0][pickerView.selectedRow(inComponent: 0)]
        let minute = hourMinuteSecondArr[1][pickerView.selectedRow(inComponent: 1)]
        let second = hourMinuteSecondArr[2][pickerView.selectedRow(inComponent: 2)]
        
        selectedValue = "\(hour) - \(minute) - \(second)"
    }

}
