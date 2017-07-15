//
//  ChangePasswordPage1ViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/15/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import MessageUI

class ChangePasswordPage1ViewController: UIViewController {

    @IBOutlet weak var vung1: UITextField!
    @IBOutlet weak var vung2: UITextField!
    @IBOutlet weak var vung3: UITextField!
    @IBOutlet weak var vung4: UITextField!
    @IBOutlet weak var vung5: UITextField!
    @IBOutlet weak var vung6: UITextField!
    @IBOutlet weak var vung7: UITextField!
    @IBOutlet weak var vung8: UITextField!
    
    var id: Int!
    var currentDevice : Device!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        setup()
    }

    @IBAction func cap1Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),241,\(vung1.text!),\(vung2.text!)"
        
        createMessage(device4: device4Body, otherDevice: "")
    }
    
    @IBAction func cap2Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),242,\(vung3.text!),\(vung4.text!)"
        createMessage(device4: device4Body, otherDevice: "")
    }
    
    @IBAction func cap3Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),243,\(vung5.text!),\(vung6.text!)"
        createMessage(device4: device4Body, otherDevice: "")
    }
    
    @IBAction func cap4Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),244,\(vung7.text!),\(vung8.text!)"
        createMessage(device4: device4Body, otherDevice: "")
    }
}

// MARK: Delegate
extension ChangePasswordPage1ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 15
    }
}

// Methods
extension ChangePasswordPage1ViewController: MFMessageComposeViewControllerDelegate {
    fileprivate func setup() {
        vung1.delegate = self
        vung2.delegate = self
        vung3.delegate = self
        vung4.delegate = self
        vung5.delegate = self
        vung6.delegate = self
        vung7.delegate = self
        vung8.delegate = self
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


