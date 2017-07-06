//
//  VolumeSettingViewController.swift
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
class VolumeSettingViewController: UIViewController,  MFMessageComposeViewControllerDelegate {
    
    var id: Int!
    var currentDevice : Device!
    
    
    @IBOutlet var volume4: UIButton!
    @IBOutlet var option4: UIButton!
    @IBOutlet var time4: UIButton!
    
    @IBAction func volume4(_ sender: Any) {
        dropdown1.show()
    }
    @IBAction func option4(_ sender: Any) {
        dropdown2.show()
    }
    @IBAction func time4(_ sender: Any) {
        dropdown3.show()
    }
    let dropdown1 = DropDown()
    let dropdown2 = DropDown()
    let dropdown3 = DropDown()
    
    var selectVolome4 = 0
    var selectoption4 = 0
    var selecttime4 = 0
    
    
    
    
    @IBOutlet var viewDevice3: UIView!
    
    @IBOutlet var volume3: UIButton!
    
    @IBAction func volume3(_ sender: Any) {
        self.dropdown4.show()
    }
    
    let dropdown4 = DropDown()
    var selectVolome3 = ""
    
    
    
    
    @IBAction func send(_ sender: Any) {
        if(currentDevice.type == 3){
            createMessage(device4: "\(currentDevice.password),27,\(selectVolome4),\(selectoption4),\(selecttime4)", otherDevice: "")
        }
        else if (currentDevice.type == 0){
            createMessage(device4: "", otherDevice: "\(currentDevice.password)62\(selectVolome3)")
        }
        else {
            createMessage(device4: "", otherDevice: "\(currentDevice.password)14\(selectVolome3)#")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpDropDown4()
        self.setUpDropDown3()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        if(currentDevice.type == 3){
            self.viewDevice3.isHidden = true
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpDropDown4(){
        let arr = ["tắt còi","mức trung bình","mức âm lớn"]
        self.dropdown1.anchorView = volume4
        self.dropdown1.dataSource = arr
        self.dropdown1.bottomOffset = CGPoint(x: 0, y:(self.dropdown1.anchorView?.plainView.bounds.height)!)
        dropdown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectVolome4 = index
            self.volume4.setTitle(arr[index], for: .normal)
            
            
        }
        
        let arr2 = ["tắt âm báo","bật âm báo"]
        self.dropdown2.anchorView = option4
        self.dropdown2.dataSource = arr2
        self.dropdown2.bottomOffset = CGPoint(x: 0, y:(self.dropdown2.anchorView?.plainView.bounds.height)!)
        dropdown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectoption4 = index
            self.option4.setTitle(arr2[index], for: .normal)
            
            
        }
        
        var arr3 = [String]()
        for i in 1...255 {
            arr3.append("\(i)")
        }
        self.dropdown3.anchorView = time4
        self.dropdown3.dataSource = arr3
        self.dropdown3.bottomOffset = CGPoint(x: 0, y:(self.dropdown3.anchorView?.plainView.bounds.height)!)
        dropdown3.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selecttime4 = index + 1
            self.time4.setTitle(arr3[index], for: .normal)
            
            
        }
        
        
    }
    
    
    func setUpDropDown3(){
        var arr = [String]()
        for i in 0...99 {
            if (i<10){
                arr.append("0\(i)")
            }
            else{
                arr.append("\(i)")
            }
            
        }
        self.dropdown4.anchorView = volume3
        self.dropdown4.dataSource = arr
        self.dropdown4.bottomOffset = CGPoint(x: 0, y:(self.dropdown3.anchorView?.plainView.bounds.height)!)
        dropdown3.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectVolome3 = arr[index]
            self.time4.setTitle(arr[index], for: .normal)
            
            
        }
    }
    
    
    ///
    
    
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
