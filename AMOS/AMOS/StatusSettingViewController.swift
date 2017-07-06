//
//  StatusSettingViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//


import UIKit
import RealmSwift
import Messages
import MessageUI

import DropDown

class StatusSettingViewController: UIViewController , MFMessageComposeViewControllerDelegate{

    
    var id: Int!
    var currentDevice : Device!
    
    let dropdown1 = DropDown()
    let dropdown2 = DropDown()
    
    var select1 = ""
    var select2 = 0
 
    @IBOutlet var zoneButton: UIButton!
    
    @IBAction func zone(_ sender: Any) {
        dropdown1.show()
    }
    
    
    @IBOutlet var status: UIButton!
    
    @IBAction func status(_ sender: Any) {
        dropdown2.show()
    }
    
    
    @IBAction func send3(_ sender: Any) {
        
        
        createMessage(device4: "", otherDevice: "\(currentDevice.password)60\(select1)\(select2)1#")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDevice = RealmManager.getCurrentDevice(id: id)
        self.setUpDropDown3()
        
        
        if(currentDevice.type ==  1){
            self.zoneButton.setTitle("000", for: .normal)
            self.select1 = "000"
        }
        else {
            self.zoneButton.setTitle("00", for: .normal)
            self.select1 = "00"
        }

    }

    func setUpDropDown3(){
        
        var arr = [String]()
        
        if(currentDevice.type == 1){
            for i in 0...120 {
                if(i < 10){
                    arr.append("00\(i)")
                }
                else if(i < 100){
                    arr.append("0\(i)")
                }
                else{
                    arr.append("\(i)")
                }
            }
        }
        else {
            for i in 0...99 {
                if(i < 10){
                    arr.append("0\(i)")
                }
                else{
                    arr.append("\(i)")
                }
            }
        }
        self.dropdown1.anchorView = zoneButton
        self.dropdown1.dataSource = arr
        self.dropdown1.bottomOffset = CGPoint(x: 0, y:(self.dropdown1.anchorView?.plainView.bounds.height)!)
        dropdown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select1 = arr[index]
            self.zoneButton.setTitle(arr[index], for: .normal)
            
            
        }
        
        var arr1 = [String]()
        if (currentDevice.type == 0 ){
            arr1 = ["Chế độ mặc định","Chế độ ở nhà","Chế độ thông minh","Chế độ khẩn cấp","Chế độ im lặng"]
        }
        else {
            arr1 = ["Chế độ mặc định","Chế độ ở nhà","Chế độ thông minh","Chế độ khẩn cấp","Chế độ im lặng","chế độ khách hàng", "chế độ lời chào" , "chế độ trợ giúp ưu tiên"]
        }
        
        
        
        self.dropdown2.anchorView = status
        self.dropdown2.dataSource = arr1
        self.dropdown2.bottomOffset = CGPoint(x: 0, y:(self.dropdown2.anchorView?.plainView.bounds.height)!)
        dropdown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select2 = index + 1
            self.status.setTitle(arr1[index], for: .normal)
            
        }

    }

    func createMessage(device4: String, otherDevice: String) {
        let messageVC = MFMessageComposeViewController()
        
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
