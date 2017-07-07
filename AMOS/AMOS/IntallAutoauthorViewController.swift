//
//  IntallAutoauthorViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/7/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import UIKit
import SnapKit
import RealmSwift
import MessageUI
import DropDown

class IntallAutoauthorViewController: UIViewController  , MFMessageComposeViewControllerDelegate{

    var id: Int!
    var currentDevice: Device!
    var pickerDataSource = [[String]]()
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var dataButton: UIButton!
    
    @IBAction func dateButton(_ sender: Any) {
        isTime  = 0
         self.datePicker.isHidden  = false
        self.pickerView.isHidden = true
        self.showDatePicker()
        
    }
    
    var isTime = 0
    var selectDate = "20170101"
    var selectTime = "000000"
    
    
    var hour = "00"
    var minute = "00"
    var second = "00"
    
    
    @IBOutlet var timeButton: UIButton!
    
    @IBAction func timeButton(_ sender: Any) {
        isTime = 1
         self.datePicker.isHidden  = true
        self.pickerView.isHidden = false
        self.showDatePicker()
    }
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var bottomContraint: NSLayoutConstraint!

    @IBAction func cancel(_ sender: Any) {
        
         hideDatePicker()
    }
    
    
    @IBAction func done(_ sender: Any) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "YYYY-MM-dd"
        let stringDate = timeFormatter.string(from: datePicker.date)
        let date = stringDate.components(separatedBy: "-")
        
        if(isTime == 0 ){
            dataButton.setTitle("\(stringDate)", for: .normal)
            selectDate = ""
            for t in date {
                if(currentDevice.type == 0 && t.characters.count == 4){
                    let start = t.index(t.startIndex, offsetBy: 2)
                    let end = t.index(t.endIndex, offsetBy: 0)
                    let range = start..<end
                    
                    let yy = t.substring(with: range)
                    selectDate = "\(selectDate)\(yy)"
                }
                else{
                    selectDate = "\(selectDate)\(t)"
                }
                
            }
        }
       
        else{
            timeButton.setTitle("\(hour):\(minute):\(second)", for: .normal)
        }
        
        hideDatePicker()
    }
    
    @IBAction func send(_ sender: Any) {
        createMessage(device4: "", otherDevice: "\(currentDevice.password)\(selectDate)\(selectTime)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        
        if currentDevice.type == 0 {
            selectDate = "170101"
        }
        
        self.setupDatePicker()
       
        
        setUpDataSource()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func setupView() {
        
    }
    
    fileprivate func setupDatePicker() {
        datePicker.datePickerMode = .date
    }
    
    fileprivate func showDatePicker() {
        bottomContraint.constant = 0
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func hideDatePicker() {
        bottomContraint.constant = -250
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func createMessage(device4: String, otherDevice: String) {
        let messageVC = MFMessageComposeViewController()
        
        let realm = try! Realm()
        
        let currentDevice = realm.object(ofType: Device.self, forPrimaryKey: id)
        messageVC.recipients = [currentDevice!.SIM]
        messageVC.body = currentDevice?.type == 3 ? device4 : otherDevice
        messageVC.messageComposeDelegate = self
        
        present(messageVC, animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            self.dismiss(animated: true, completion: nil)
        case .failed:
            self.dismiss(animated: true, completion: nil)
        case .sent:
            self.dismiss(animated: true, completion: nil)
        }
    }


}
extension IntallAutoauthorViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func setUpDataSource(){
        let hour: [String] = {
            var arr = [String]()
            
            for i in 0...23 {
                if i < 10 {
                    arr.append("0\(i)H")
                } else {
                    arr.append("\(i)H")
                }
            }
            return arr
        }()
        
        let minute: [String] = {
            var arr = [String]()
            
            for i in 0...59 {
                if i < 10 {
                    arr.append("0\(i)m")
                } else {
                    arr.append("\(i)m")
                }
            }
            return arr
        }()
        
        let second: [String] = {
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
        self.pickerDataSource = [hour,minute,second]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isTime == 1  {
            switch component {
            case 0:
                if(row < 10){
                    hour = "0\(row)"
                }
                else {
                    hour = "\(row)"
                }
            case 1:
                if(row < 10){
                    minute = "0\(row)"
                }
                else {
                    minute = "\(row)"
                }
            case 2:
                if(row < 10){
                    second = "0\(row)"
                }
                else {
                    second = "\(row)"
                }
                
            default:
                    break
            }
            selectTime = "\(hour)\(minute)\(second)"
            
        }
    }
}







