//
//  ControlCenterViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Messages
import MessageUI
import RealmSwift

class ControlCenterViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    // Input properties
    var id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func turnSystemOn(_ sender: UIButton) {
        createMessage(device4: "888888,01", otherDevice: "12341#")
    }
    
    func createMessage(device4: String, otherDevice: String) {
        let messageVC = MFMessageComposeViewController()
        
        let realm = try! Realm()
        
        let currentDevice = realm.object(ofType: Device.self, forPrimaryKey: id)
        messageVC.recipients = [currentDevice!.SIM]
        messageVC.body = currentDevice?.type == 3 ? device4 : otherDevice
        messageVC.messageComposeDelegate = self
        
        present(messageVC, animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
}
