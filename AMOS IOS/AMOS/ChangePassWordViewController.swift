//
//  ChangePassWordViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import Messages
import MessageUI

class ChangePassWordViewController: UIViewController ,MFMessageComposeViewControllerDelegate,UITextFieldDelegate {
    
    
    // Input properties
    var id: Int!
    var currentDevice : Device!
    
    
    @IBOutlet var newPass: UITextField!

    @IBAction func sendButton(_ sender: Any) {
        var index = 0
        
        if (currentDevice.type == 3){
            index = 6
        }
        else{
            index = 4
        }
        
        if (!(newPass.text?.isEmpty)! && newPass.text?.characters.count ==  index) {
            createMessage(device4: "\(currentDevice.password),40,000,\(newPass.text!)", otherDevice: "\(currentDevice.password)50\(newPass.text!)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newPass.delegate = self
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        var length = 0
        if self.currentDevice.type == 3 {
            length = 6
        }
        else {
            length = 4
        }
        
        return newLength <= length
    }
    
}
