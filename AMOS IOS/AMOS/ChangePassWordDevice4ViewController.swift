//
//  ChangePassWordDevice4ViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/16/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import Messages
import MessageUI
import Realm

class ChangePassWordDevice4ViewController: UIViewController,MFMessageComposeViewControllerDelegate,UITextFieldDelegate {
    
    
    var id: Int!
    var currentDevice : Device!

 
    @IBOutlet var programPassword: UITextField!
    @IBOutlet var duressPassword: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    
    @IBAction func send(_ sender: Any) {
        if ( programPassword.text?.characters.count ==  6 && duressPassword.text?.characters.count ==  4 && duressPassword.text?.characters.count ==  4){
            
            let oldPass  = currentDevice.password
            // update Device Realm
            createMessage(device4: "\(oldPass),35,\(programPassword.text!),\(userPassword.text!),\(duressPassword.text!)", otherDevice: "", newPassword: programPassword.text!)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        self.programPassword.text = currentDevice.password
        
        self.duressPassword.delegate = self
        self.userPassword.delegate = self
        self.programPassword.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func createMessage(device4: String, otherDevice: String, newPassword: String) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.recipients = [currentDevice!.SIM]
        messageVC.body = currentDevice?.type == 3 ? device4 : otherDevice
        messageVC.messageComposeDelegate = self
        
        present(messageVC, animated: true) {
            let realm = try! Realm()
            
            try! realm.write {
                self.currentDevice.password = newPassword
            }
        }
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
        if  textField == programPassword {
            length = 6
        }
        else {
            length = 4
        }
        
        return newLength <= length
    }
    

}
