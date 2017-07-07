//
//  ChangeMessage2ViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/7/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

class ChangeMessage2ViewController: UIViewController {

    @IBOutlet weak var vung1: UITextField!
    @IBOutlet weak var vung2: UITextField!
    @IBOutlet weak var vung3: UITextField!
    @IBOutlet weak var vung4: UITextField!
    @IBOutlet weak var vung5: UITextField!
    @IBOutlet weak var vung6: UITextField!
    @IBOutlet weak var vung7: UITextField!
    @IBOutlet weak var vung8: UITextField!
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

    @IBAction func sendPressed(_ sender: UIButton) {
        let password = currentDevice.password
        
        let device4Body =
            "\(password)241\(vung1.text!)\(vung2.text!)" +
            "\(password)241\(vung3.text!)\(vung4.text!)" +
            "\(password)241\(vung5.text!)\(vung6.text!)" +
            "\(password)241\(vung7.text!)\(vung8.text!)" +
            "\(password)241\(vung9.text!)\(vung10.text!)" +
            "\(password)241\(vung11.text!)\(vung12.text!)" +
            "\(password)241\(vung13.text!)\(vung14.text!)" +
            "\(password)241\(vung15.text!)\(vung16.text!)"
        
        createMessage(device4: device4Body, otherDevice: "")
    }
}

// MARK: Delegate
extension ChangeMessage2ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 15
    }
}

// Methods
extension ChangeMessage2ViewController: MFMessageComposeViewControllerDelegate {
    fileprivate func setup() {
        vung1.delegate = self
        vung2.delegate = self
        vung3.delegate = self
        vung4.delegate = self
        vung5.delegate = self
        vung6.delegate = self
        vung7.delegate = self
        vung8.delegate = self
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
