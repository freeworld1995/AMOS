//
//  StatusSetting2Page2ViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/15/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import DropDown
import RealmSwift
import MessageUI

class StatusSetting2Page2ViewController: UIViewController {

    
    var id: Int!
    var currentDevice : Device!
    @IBOutlet var zoneCollection: [UIButton]!
    
    var selectedZone = 0
    
    let dropdown = DropDown()
    
    var stringArr = ["Chế độ báo trộm", "Độ trễ cảm biến", "Chế độ lặp", "Chế độ báo cháy", "Chế độ báo GAS", "Chế độ im lặng", "Chế độ SOS", "Chế độ SOS", "Chế độ báo nhắc nhở", "Chế độ báo khách", "Hủy bỏ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDevice = RealmManager.getCurrentDevice(id: id)
        setup()
    }
    
    @IBAction func zonePressed(_ sender: UIButton) {
        selectedZone = sender.tag
        dropdown.anchorView = sender
        dropdown.bottomOffset = CGPoint(x: 0, y: -(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.show()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        let device4Body = "\(currentDevice.password),232,\(buttonTitle(9)),\(buttonTitle(10)),\(buttonTitle(11)),\(buttonTitle(12)),\(buttonTitle(13)),\(buttonTitle(14)),\(buttonTitle(15)),\(buttonTitle(16))"
        
        createMessage(device4: device4Body, otherDevice: "")
    }
    
    func buttonTitle(_ zone: Int) -> String {
        
        let title = zoneCollection.filter { $0.tag == zone }.first!.titleLabel!.text!
        
        let zone = zoneCollection.index { (button) -> Bool in
            button.titleLabel!.text == title
        }
        return "\(zone! + 1)"
    }

}

// Methods
extension StatusSetting2Page2ViewController: MFMessageComposeViewControllerDelegate {
    fileprivate func setup() {
        var arr = [String]()
        
        for i in 1...11 {
            arr.append("\(i)")
        }
        
        dropdown.dataSource = stringArr
        
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.zoneCollection.filter { $0.tag == self.selectedZone}.first?.setTitle(self.stringArr[index], for: .normal)
        }
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

