//
//  CancelSettingViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/7/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import MessageUI
import DropDown
class CancelSettingViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var id: Int!
    var currentDevice: Device!
    
    
     let dropdown1 = DropDown()
    
    @IBOutlet var cancelZone: UIButton!
    
    @IBAction func cancelZone(_ sender: Any) {
        dropdown1.show()
    }
    
    var cancelZoneSelect = ""
    
    @IBOutlet var viewCancelZone: UIView!
    
    
    
    
    
    var isTime = 0
    
    var selectOn = [String]()
    var selectOff = [String]()
    
    
    @IBOutlet var bottomContraint: NSLayoutConstraint!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var timeOn: UIButton!
    
    @IBAction func timeOn(_ sender: Any) {
        
        isTime = 1
        self.showDatePicker()
        
    }
    
    @IBOutlet var timeOff: UIButton!
    
    @IBAction func timeOff(_ sender: Any) {
        isTime = 0
        self.showDatePicker()
    }
    
    @IBAction func cancel(_ sender: Any) {
        hideDatePicker()
    }

    @IBAction func done(_ sender: Any) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let stringDate = timeFormatter.string(from: datePicker.date)
        let time = stringDate.components(separatedBy: ":")
        if(isTime == 1 ){
            timeOn.setTitle("\(stringDate)", for: .normal)
            selectOn = time
        }
        else{
            timeOff.setTitle("\(stringDate)", for: .normal)
            selectOff = time
        }
    
        hideDatePicker()
    }
    
    
    
    @IBAction func send(_ sender: Any) {
      
        
        if currentDevice.type == 3 {
            if(selectOn.count > 0 && selectOff.count > 0){
                createMessage(device4: "\(currentDevice.password),291,\(selectOn[0])\(selectOn[1]),\(selectOff[0])\(selectOff[1])", otherDevice: "")
            }

        }
        else{
            if currentDevice.type == 1 {
                createMessage(device4: "", otherDevice: "\(currentDevice.password)57\(cancelZoneSelect)0#")
            }
            else{
                
                createMessage(device4: "", otherDevice: "\(currentDevice.password)57\(cancelZoneSelect)240002400#")
            }
        }
//
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDevice = RealmManager.getCurrentDevice(id: id)
        
        setupDatePicker()
        if currentDevice.type == 3 {
            viewCancelZone.isHidden  = true
        }
        else{
            setUpDropDown()
        }
        
        // Do any additional setup after loading the view.
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
    
    
    func setUpDropDown(){
        
        var arr = [String]()
        
        arr = ["01","02","03","04"];
        
        self.dropdown1.anchorView = cancelZone
        self.dropdown1.dataSource = arr
        self.dropdown1.bottomOffset = CGPoint(x: 0, y:(self.dropdown1.anchorView?.plainView.bounds.height)!)
        dropdown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.cancelZoneSelect = arr[index]
            self.cancelZone.setTitle(arr[index], for: .normal)
            
            
        }
    }

}
