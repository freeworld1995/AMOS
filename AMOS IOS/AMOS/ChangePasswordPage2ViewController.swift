//
//  ChangePasswordPage2ViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/15/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import MessageUI

class ChangePasswordPage2ViewController: UIViewController {
    
    @IBOutlet weak var vung9: UITextField!
    @IBOutlet weak var vung10: UITextField!
    @IBOutlet weak var vung11: UITextField!
    @IBOutlet weak var vung12: UITextField!
    @IBOutlet weak var vung13: UITextField!
    @IBOutlet weak var vung14: UITextField!
    @IBOutlet weak var vung15: UITextField!
    @IBOutlet weak var vung16: UITextField!

    var id: Int!
    var currentDevice : Device!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        setup()
    }
    
    @IBAction func cap5Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),245,\(vung9.text!),\(vung10.text!)"
        
        createMessage(device4: device4Body, otherDevice: "")
    }
    
    @IBAction func cap6Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),246,\(vung11.text!),\(vung12.text!)"
        createMessage(device4: device4Body, otherDevice: "")
    }
    
    @IBAction func cap7Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),247,\(vung13.text!),\(vung14.text!)"
        createMessage(device4: device4Body, otherDevice: "")
    }
    
    @IBAction func cap8Pressed(_ sender: UIButton) {
        let password = currentDevice.password
        let device4Body = "\(password),248,\(vung15.text!),\(vung16.text!)"
        createMessage(device4: device4Body, otherDevice: "")
    }
    
}

// MARK: Delegate
extension ChangePasswordPage2ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 15
    }
}

// Methods
extension ChangePasswordPage2ViewController: MFMessageComposeViewControllerDelegate {
    fileprivate func setup() {
        vung9.delegate = self
        vung10.delegate = self
        vung11.delegate = self
        vung12.delegate = self
        vung13.delegate = self
        vung14.delegate = self
        vung15.delegate = self
        vung16.delegate = self
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

