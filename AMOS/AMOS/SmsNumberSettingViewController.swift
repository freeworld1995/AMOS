//
//  SmsNumberSettingViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

import RealmSwift
import Messages
import MessageUI
class SmsNumberSettingViewController: UIViewController,MFMessageComposeViewControllerDelegate {
    
    // Input properties
    var id: Int!
    var currentDevice : Device!
    
    @IBOutlet var numberOne: UITextField!
    @IBOutlet var numberTow: UITextField!
    @IBOutlet var numberThree: UITextField!

    
    @IBAction func installOne(_ sender: Any) {
        if !(numberOne.text?.isEmpty)! {
            createMessage(device4: "", otherDevice: "12341\(numberOne.text!)#")
        }
    }
    
    @IBAction func installTow(_ sender: Any) {
        
        if !(numberTow.text?.isEmpty)! {
            createMessage(device4: "", otherDevice: "12342\(numberTow.text!)#")
        }
    }
    
    @IBAction func installThree(_ sender: Any) {
        
        if !(numberThree.text?.isEmpty)! {
            createMessage(device4: "", otherDevice: "12343\(numberThree.text!)#")
        }
    }
    
    
    
    @IBAction func deleteOne(_ sender: Any) {
        createMessage(device4: "", otherDevice: "12341#")
    }
    @IBAction func deleteTwo(_ sender: Any) {
        createMessage(device4: "", otherDevice: "12342#")
    }
    @IBAction func deleteThree(_ sender: Any) {
        createMessage(device4: "", otherDevice: "12343#")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        currentDevice = RealmManager.getCurrentDevice(id: id)
    }

    func dismissKeyboard() {
        
        view.endEditing(true)
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
