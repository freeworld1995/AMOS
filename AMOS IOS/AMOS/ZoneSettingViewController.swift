//
//  zoneSettingViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
import UIKit
import RealmSwift
import Messages
import MessageUI

import DropDown
class ZoneSettingViewController: UIViewController, MFMessageComposeViewControllerDelegate{
    
    var id: Int!
    var currentDevice : Device!
    
    let dropdown1 = DropDown()
    let dropdown2 = DropDown()
    let dropdown3 = DropDown()
  
    var select1 = ""
    var select2 = ""
    var select3 = ""
    
    @IBOutlet var timeGroup: UIButton!
    
    @IBAction func timeGroup(_ sender: Any) {
        dropdown1.show()
        
    }
    
    @IBOutlet var startZone: UIButton!
    
    @IBAction func startZone(_ sender: Any) {
        dropdown2.show()
        
    }
    
    
    @IBOutlet var endZone: UIButton!

    @IBAction func endZone(_ sender: Any) {
        dropdown3.show()
        
    }
    
    
    @IBAction func send(_ sender: Any) {
        createMessage(device4: "", otherDevice: "\(currentDevice.password)58\(select1)\(select2)\(select3)#")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDevice = RealmManager.getCurrentDevice(id: id)
        self.setUpDropDown()
        
        
        if(currentDevice.type ==  1){
            self.startZone.setTitle("000", for: .normal)
            self.endZone.setTitle("000", for: .normal)
            self.select2 = "000"
            self.select3 = "000"
            
        }
        else {
            self.startZone.setTitle("00", for: .normal)
            self.endZone.setTitle("00", for: .normal)
            self.select2 = "00"
            self.select3 = "00"
        }
        // Do any additional setup after loading the view.
    }

    
    
    func setUpDropDown(){
        
        var arr = [String]()
        var arr1 = [String]()
        
        arr = ["01","02","03","04"];
        
        self.dropdown1.anchorView = timeGroup
        self.dropdown1.dataSource = arr
        self.dropdown1.bottomOffset = CGPoint(x: 0, y:(self.dropdown1.anchorView?.plainView.bounds.height)!)
        dropdown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select1 = arr[index]
            self.timeGroup.setTitle(arr[index], for: .normal)
            
            
        }
        
        
        
        
        if(currentDevice.type == 1){
            for i in 0...120 {
                if(i < 10){
                    arr1.append("00\(i)")
                }
                else if(i < 100){
                    arr1.append("0\(i)")
                }
                else{
                    arr1.append("\(i)")
                }
            }
        }
        else {
            for i in 0...99 {
                if(i < 10){
                    arr1.append("0\(i)")
                }
                else{
                    arr1.append("\(i)")
                }
            }
        }
        self.dropdown2.anchorView = startZone
        self.dropdown2.dataSource = arr1
        self.dropdown2.bottomOffset = CGPoint(x: 0, y:(self.dropdown2.anchorView?.plainView.bounds.height)!)
        dropdown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select2 = arr1[index]
            self.startZone.setTitle(arr1[index], for: .normal)
            
        }
        
        
        self.dropdown3.anchorView = endZone
        self.dropdown3.dataSource = arr1
        self.dropdown3.bottomOffset = CGPoint(x: 0, y:(self.dropdown3.anchorView?.plainView.bounds.height)!)
        dropdown3.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select3 = arr1[index]
            self.endZone.setTitle(arr1[index], for: .normal)
            
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
