//
//  AvalibleSettingViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import Messages
import MessageUI

import DropDown
class AvalibleSettingViewController: UIViewController ,MFMessageComposeViewControllerDelegate {
    
    var id: Int!
    var currentDevice : Device!
    
    var select1 = ""
    var select2 = 1
    
    let dropdown1 = DropDown()
    let dropdown2 = DropDown()
    
    @IBOutlet var vongDay: UIButton!
    
    @IBAction func vongDay(_ sender: Any) {
        dropdown1.show()
        
    }
    
    
    @IBOutlet var cheDo: UIButton!
    @IBAction func cheDo(_ sender: Any) {
        dropdown2.show()
    }
    
    
    @IBOutlet var viewTrangThai: UIView!
    
    @IBOutlet var onCheckBox: VKCheckbox!
      
    @IBOutlet var offCheckBox: VKCheckbox!
    
    @IBAction func send(_ sender: Any) {
        
        if(currentDevice.type == 0){
            createMessage(device4: "", otherDevice: "\(currentDevice.password)61\(select1)\(select2)10/1")
        }
        else{
            
            if(onCheckBox.isOn()){
                createMessage(device4: "", otherDevice: "\(currentDevice.password)61\(select1)0#")
            }
            else{
                createMessage(device4: "", otherDevice: "\(currentDevice.password)61\(select1)1#")
            }
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        currentDevice = RealmManager.getCurrentDevice(id: id)
        self.setUpDropDown()
        self.setUpCheckBox()
        
        onCheckBox.checkboxValueChangedBlock = {
            isOn in
            print("Basic checkbox is \(isOn ? "ON" : "OFF")")
            if(isOn){
                self.offCheckBox.setOn(false)
            }
        }
        
        offCheckBox.checkboxValueChangedBlock = {
            isOn in
            print("Basic checkbox is \(isOn ? "ON" : "OFF")")
            if(isOn){
                self.onCheckBox.setOn(false)
            }
        }
        
        if(currentDevice.type != 0){
            self.viewTrangThai.isHidden = true
        }
        if(currentDevice.type == 2){
            self.vongDay.setTitle("51", for: .normal)
             self.select1 = "51"
        }
        else if (currentDevice.type == 1){
            self.vongDay.setTitle("051", for: .normal)
            self.select1 = "051"
        }
        else {
            self.vongDay.setTitle("07", for: .normal)
            self.select1 = "07"
            self.select2 = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpCheckBox(){
    
        self.onCheckBox.setOn(true, animated: true)
        self.offCheckBox.setOn(false, animated: true)
        
      
        
        
    }
    func setUpDropDown(){
        var arr = [String]()
        var arr1 = [String]()
        if(currentDevice.type == 2){
            arr = ["51","52","53","54"]
        }
        else if (currentDevice.type == 1){
            arr = ["051","052"]
        }
        else {
            arr = ["07","08","09","10"]
            arr1 = ["Chế độ mặc định","Chế độ ở nhà","Chế độ thông minh","Chế độ khẩn cấp","Chế độ im lặng"]
        }
        self.dropdown1.anchorView = vongDay
        self.dropdown1.dataSource = arr
        self.dropdown1.bottomOffset = CGPoint(x: 0, y:(self.dropdown1.anchorView?.plainView.bounds.height)!)
        dropdown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select1 = arr[index]
            self.vongDay.setTitle(arr[index], for: .normal)
            
            
        }
        
        self.dropdown2.anchorView = cheDo
        self.dropdown2.dataSource = arr1
        self.dropdown2.bottomOffset = CGPoint(x: 0, y:(self.dropdown2.anchorView?.plainView.bounds.height)!)
        dropdown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select2 = index  + 1
            self.cheDo.setTitle(arr1[index], for: .normal)
            
            
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
