//
//  AutomaticTimeSettingViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import SnapKit
import DropDown
import MessageUI
import RealmSwift

class AutomaticTimeSettingViewController: UIViewController {
    
    var timeGroup = DropDown()
    var timeOn = DropDown()
    var timeOff = DropDown()
    var day = DropDown()
    
    var id: Int!
    var currentDevice: Device!
    
    @IBOutlet weak var groupBtn: UIButton!
    @IBOutlet weak var timeOnBtn: UIButton!
    @IBOutlet weak var timeOffBtn: UIButton!
    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var grouplbl: UILabel!
    
    var select1 = "01"
    var select2 = "00"
    var select3 = "00"
    var select4 = 1
    
    lazy var hourArr: [String] = {
        var array = [String]()
        for i in 0...24 {
            if(i<10){
                array.append("0\(i)")
            }
            else {
                array.append("\(i)")
            }
            
        }
        
        return array
    }()
    
    lazy var dayArr: [String] = {
        return [
            "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "Chủ nhật"
        ]
    }()
    
    lazy var group: [String] = {
        return ["01", "02", "03", "04"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        
        if currentDevice.type == 3 {
            groupBtn.isHidden = true
            grouplbl.isHidden = true
        } else {
            groupBtn.isHidden = false
            grouplbl.isHidden = false
        }
        
        setup()
    }
    
    @IBAction func groupBtnPressed(_ sender: UIButton) {
        timeGroup.show()
    }
    
    @IBAction func timeOnBtnPressed(_ sender: UIButton) {
        timeOn.show()
    }
    
    @IBAction func timeOffBtnPressed(_ sender: UIButton) {
        timeOff.show()
    }
    
    @IBAction func dayBtnPressed(_ sender: UIButton) {
        day.show()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        let device4Body = "\(currentDevice.password)291\(select2)\(select3)1234567"
        let otherBody = "\(currentDevice.password)57\(select1)\(select2)\(select3)\(select4)#"
        createMessage(device4: device4Body, otherDevice: otherBody)
    }
}

// MARK: Methods
extension AutomaticTimeSettingViewController: MFMessageComposeViewControllerDelegate {
    fileprivate func setup() {
        timeGroup.dataSource = group
        timeOn.dataSource = hourArr
        timeOff.dataSource = hourArr
        day.dataSource = dayArr
        
        timeGroup.anchorView = groupBtn
        timeOn.anchorView = timeOnBtn
        timeOff.anchorView = timeOffBtn
        day.anchorView = dayBtn
        
        timeGroup.bottomOffset = CGPoint(x: 0, y:(timeGroup.anchorView?.plainView.bounds.height)!)
        timeOn.bottomOffset = CGPoint(x: 0, y:(timeOn.anchorView?.plainView.bounds.height)!)
        timeOff.bottomOffset = CGPoint(x: 0, y:(timeOff.anchorView?.plainView.bounds.height)!)
        day.bottomOffset = CGPoint(x: 0, y:(day.anchorView?.plainView.bounds.height)!)
        
        timeGroup.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select1 = item
            self.groupBtn.setTitle(item, for: .normal)
        }
        
        timeOn.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select2 = item
            self.timeOnBtn.setTitle(item, for: .normal)
        }
        
        timeOff.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select3 = item
            self.timeOffBtn.setTitle(item, for: .normal)
        }
        
        day.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select4 = index + 1
            self.dayBtn.setTitle(item, for: .normal)
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
    
}


