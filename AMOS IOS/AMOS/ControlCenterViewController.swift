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
    var id: Int!
    var currentDevice: Device!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        currentDevice = RealmManager.getCurrentDevice(id: id)
    }

    @IBAction func turnSystemOn(_ sender: UIButton) {
        createMessage(device4: "888888,01", otherDevice: "12341#")
    }
    
    
    @IBAction func turnSystemOff(_ sender: Any) {
        createMessage(device4: "888888,03", otherDevice: "12340#")
    }
    
    
    @IBAction func replayOn(_ sender: Any) {
        createMessage(device4: "888888,05", otherDevice: "12343#")
    }
    
    @IBAction func replayOff(_ sender: Any) {
        createMessage(device4: "888888,06", otherDevice: "12344#")
    }
    
    @IBAction func home(_ sender: Any) {
        createMessage(device4: "888888,02", otherDevice: "12342#")
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
    
    @IBAction func showCamera(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://itunes.apple.com/vn/app/yoosee/id981863450?l=vi&mt=8")! as URL)
        
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
