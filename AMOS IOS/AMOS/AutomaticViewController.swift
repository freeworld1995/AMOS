//
//  InstallTimeAutoViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/15/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import UIKit
import SnapKit
import RealmSwift
import MessageUI
import DropDown


class AutomaticViewController: UIViewController ,MFMessageComposeViewControllerDelegate{
    
    var id: Int!
    var currentDevice: Device!
    
    
    @IBOutlet var t2: VKCheckbox!
    
    @IBOutlet var t3: VKCheckbox!
    
    @IBOutlet var t4: VKCheckbox!
    
    @IBOutlet var t5: VKCheckbox!
    
    @IBOutlet var t6: VKCheckbox!
    
    @IBOutlet var t7: VKCheckbox!
    
    @IBOutlet var cn: VKCheckbox!
    
    @IBAction func send(_ sender: Any) {
        var time = ""
        if(t2.isOn()){
            time = "\(time)1"
        }
        else{
            time = "\(time)0"
        }
        if(t3.isOn()){
            time = "\(time)1"
        }
        else{
            time = "\(time)0"
        }
        if(t4.isOn()){
            time = "\(time)1"
        }
        else{
            time = "\(time)0"
        }
        if(t5.isOn()){
            time = "\(time)1"
        }
        else{
            time = "\(time)0"
        }
        if(t6.isOn()){
            time = "\(time)1"
        }
        else{
            time = "\(time)0"
        }
        if(t7.isOn()){
            time = "\(time)1"
        }
        else{
            time = "\(time)0"
        }
        if(cn.isOn()){
            time = "\(time)1"
        }
        else{
            time = "\(time)0"
        }
        createMessage(device4: "", otherDevice: "\(self.currentDevice.password))\(select1)\(selectTimeOn)\(selectTimeOff)\(time)")
//
    }
    
    
    
    
    
    @IBAction func groupButton(_ sender: Any) {
        timeGroup.show()
    }
    
    @IBOutlet var groupButton: UIButton!
    @IBOutlet var timeOnBtn: UIButton!
    @IBOutlet var timeOffBtn: UIButton!
    @IBAction func timeOnBtn(_ sender: Any) {
        self.timeStart = true
        self.showDatePicker()
    }
    @IBAction func timeOffBtn(_ sender: Any) {
        self.timeStart = false
        self.showDatePicker()
        
    }
    
    var selectTimeOn = "00:00"
    var selectTimeOff = "00:00"
    
    var timeGroup = DropDown()
    
    lazy var group: [String] = {
        return ["01", "02", "03", "04"]
    }()
    
     var select1 = "01"
    
    
    
    var timeStart = false
    @IBOutlet var bottomContraint: NSLayoutConstraint!
    
    @IBOutlet var datePicker: UIDatePicker!

    @IBAction func cancel(_ sender: Any) {
        hideDatePicker()
    }
    
    @IBAction func done(_ sender: Any) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let stringDate = timeFormatter.string(from: datePicker.date)
        
        if(timeStart){
            timeOnBtn.setTitle("\(stringDate)", for: .normal)
            selectTimeOn = "\(stringDate)"
        }
            
        else{
            timeOffBtn.setTitle("\(stringDate)", for: .normal)
            selectTimeOff = "\(stringDate)"
        }
        
        hideDatePicker()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        setUpTimeGroup()
        self.setupDatePicker()
        
        
        // Do any additional setup after loading the view.
    }

    
    
    func setUpTimeGroup(){
        
        
        self.timeGroup.anchorView = groupButton
        self.timeGroup.dataSource = group
        self.timeGroup.bottomOffset = CGPoint(x: 0, y:(self.timeGroup.anchorView?.plainView.bounds.height)!)
        timeGroup.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select1 = self.group[index]
            self.groupButton.setTitle(self.group[index], for: .normal)
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func createMessage(device4: String, otherDevice: String) {
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
    
    
    fileprivate func setupView() {
        
    }
    
    fileprivate func setupDatePicker() {
        datePicker.datePickerMode = .time
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
    
}
