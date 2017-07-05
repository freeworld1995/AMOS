//
//  DelayValiableViewController.swift
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

class DelayValiableViewController: UIViewController , MFMessageComposeViewControllerDelegate{
    
    var id: Int!
    var currentDevice : Device!
    
    var type : Int!

    let dropdown1 = DropDown()
    let dropdown2 = DropDown()
    
    var selectDelay4 = 0
    var selectRote4 = 0
    
    @IBOutlet var delayTime4: UIButton!
    
    @IBOutlet var roteTime: UIButton!
    
    @IBAction func delayTime4(_ sender: Any) {
        dropdown1.show()
    }
    
    @IBAction func roteTime(_ sender: Any) {
        dropdown2.show()
    }
    
    
    let dropdown4 = DropDown()
    var selectVolome3 = ""
    
    @IBOutlet var delayTime3: UIButton!
    
    @IBAction func delayTime3(_ sender: Any) {
        dropdown4.show()
    }
    
    @IBOutlet var viewDevice3: UIView!
    
    
    
    
    @IBAction func send(_ sender: Any) {
        if (self.type == 10){
            createMessage(device4: "\(currentDevice.password),26,\(selectDelay4),Y,\(selectRote4)", otherDevice: "\(currentDevice.password)51\(selectVolome3)")
        }
        else {
            createMessage(device4: "\(currentDevice.password),26,X,\(selectDelay4),\(selectRote4)", otherDevice: "\(currentDevice.password)52\(selectVolome3)")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        self.setUpDropDown4()
        self.setUpDropDown3()
        if(currentDevice.type == 3){
            self.viewDevice3.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpDropDown4(){
        var arr = [String]()
        for i in 0...255 {
            arr.append("\(i)")
        }
        self.dropdown1.anchorView = delayTime4
        self.dropdown1.dataSource = arr
        self.dropdown1.bottomOffset = CGPoint(x: 0, y:(self.dropdown1.anchorView?.plainView.bounds.height)!)
        dropdown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectDelay4 = index
            self.delayTime4.setTitle(arr[index], for: .normal)
            
            
        }
        
        var arr2 = [String]()
        for i in 1...15 {
            arr2.append("\(i)")
        }
        self.dropdown2.anchorView = roteTime
        self.dropdown2.dataSource = arr2
        self.dropdown2.bottomOffset = CGPoint(x: 0, y:(self.dropdown2.anchorView?.plainView.bounds.height)!)
        dropdown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectRote4 = index + 1
            self.roteTime.setTitle(arr2[index], for: .normal)
            
            
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
        self.dropdown4.anchorView = delayTime3
        self.dropdown4.dataSource = arr
        self.dropdown4.bottomOffset = CGPoint(x: 0, y:(self.dropdown4.anchorView?.plainView.bounds.height)!)
        dropdown4.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectVolome3 = arr[index]
            self.delayTime3.setTitle(arr[index], for: .normal)
            
            
        }
    }
    
    
    //
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
