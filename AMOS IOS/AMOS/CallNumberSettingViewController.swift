//
//  CallNumberSettingViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

import RealmSwift
import Messages
import MessageUI
class CallNumberSettingViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet var bottomScroll: NSLayoutConstraint!
    @IBOutlet var scroll: UIScrollView!
    
    // Input properties
    var id: Int!
    var currentDevice : Device!
    
    @IBOutlet var numberOne: UITextField!
    @IBOutlet var numberTwo: UITextField!
    @IBOutlet var numberThree: UITextField!
    @IBOutlet var numberFour: UITextField!
    @IBOutlet var numberFive: UITextField!
    @IBOutlet var numberSix: UITextField!
    @IBOutlet var numberSeven: UITextField!
    @IBOutlet var numberEight: UITextField!
    
    // install
    @IBAction func installOne(_ sender: Any) {
        
        if !(numberOne.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)31\((numberOne.text)!)#")
        }
        
    }
    @IBAction func installTow(_ sender: Any) {
        if !(numberTwo.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)32\((numberTwo.text)!)#")
        }

    }
    @IBAction func installThree(_ sender: Any) {
        if !(numberThree.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)33\((numberThree.text)!)#")
        }
    }
    @IBAction func installOFour(_ sender: Any) {
        if !(numberFour.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)34\((numberFour.text)!)#")
        }
    }
    @IBAction func installFive(_ sender: Any) {
        if !(numberFive.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)35\((numberFive.text)!)#")
        }
    }
    @IBAction func installSix(_ sender: Any) {
        if !(numberSix.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)36\((numberSix.text)!)#")
        }
    }
    @IBAction func installSeven(_ sender: Any) {
        if !(numberSeven.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)37\((numberSeven.text)!)#")
        }
    }
    @IBAction func installEight(_ sender: Any) {
        if !(numberEight.text?.isEmpty)! {
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)38\((numberEight.text)!)#")
        }
    }
    
    // delete
    @IBAction func deleteOne(_ sender: Any) {
       
            createMessage(device4: "\(currentDevice.password),,\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)31#")
        
    }
    
    @IBAction func deleteTow(_ sender: Any) {
        
            createMessage(device4: "\(currentDevice.password),\(numberOne.text!),,\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)32#")
        
    }
    
    @IBAction func deleteThree(_ sender: Any) {
        createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),,\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)33#")
    }
    
    @IBAction func deleteFour(_ sender: Any) {
        createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),,\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)34#")
    }
    
    @IBAction func deleteFive(_ sender: Any) {
        createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),,\(numberSix.text!),\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)35#")
    }
    
    @IBAction func deleteSix(_ sender: Any) {
        createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),,\(numberSeven.text!),\(numberEight.text!)", otherDevice: "\(currentDevice.password)36#")
    }
    
    @IBAction func deleteSeven(_ sender: Any) {
        createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),,\(numberEight.text!)", otherDevice: "\(currentDevice.password)37#")
    }
    
    @IBAction func deleteEight(_ sender: Any) {
        createMessage(device4: "\(currentDevice.password),\(numberOne.text!),\(numberTwo.text!),\(numberThree.text!),\(numberFour.text!),\(numberFive.text!),\(numberSix.text!),\(numberSeven.text!),", otherDevice: "\(currentDevice.password)38#")
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
