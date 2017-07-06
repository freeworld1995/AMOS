//
//  ChangeMessageViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import Messages
import MessageUI
import DropDown

class ChangeMessageViewController: UIViewController, UITextViewDelegate , MFMessageComposeViewControllerDelegate{
    
    var id: Int!
    var currentDevice : Device!
    let dropdown1 = DropDown()
    var select1 = "00"
    
    @IBOutlet var zoneButton: UIButton!
    
    @IBAction func zone(_ sender: Any) {
        dropdown1.show()
        
    }
    
    @IBOutlet var contentMessage: UITextView!
    
    
    @IBOutlet var send: UIButton!
    @IBAction func send(_ sender: Any) {
        
        if(currentDevice.type == 0){
            if(contentMessage.text != "" && contentMessage.text != "nội dung tin nhắn..." ){
                createMessage(device4: "", otherDevice: "\(currentDevice.password)8\(select1)\((contentMessage.text)!)#")
            }
           
        }
        else {
            if(contentMessage.text != "" && contentMessage.text != "nội dung tin nhắn..." ){
                createMessage(device4: "", otherDevice: "\(currentDevice.password)80\(select1)\((contentMessage.text)!)#")
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let ae  = realm.objects(Device.self)
        currentDevice = RealmManager.getCurrentDevice(id: (ae.last?.id)!)
        
        if(currentDevice.type == 1){
            select1 = "000"
        }
        
        contentMessage.text = "nội dung tin nhắn..."
        contentMessage.textColor = UIColor.darkGray
        contentMessage.delegate = self
        contentMessage.layer.borderWidth = 1
        
        self.setUpDropDown()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        if(contentMessage.text.characters.count == 0){
            contentMessage.textColor = UIColor.darkGray
            contentMessage.text = "nội dung tin nhắn..."
            contentMessage.resignFirstResponder()
        }
        view.endEditing(true)
    }
    
    func setUpDropDown(){
        var arr = [String]()
        
        if(currentDevice.type == 1){
            for i in 0...120 {
                if(i < 10){
                    arr.append("00\(i)")
                }
                else if(i < 100){
                    arr.append("0\(i)")
                }
                else{
                    arr.append("\(i)")
                }
            }
        }
        else {
            for i in 0...99 {
                if(i < 10){
                    arr.append("0\(i)")
                }
                else{
                    arr.append("\(i)")
                }
            }
        }
        
        self.dropdown1.anchorView = zoneButton
        self.dropdown1.dataSource = arr
        self.dropdown1.bottomOffset = CGPoint(x: 0, y:(self.dropdown1.anchorView?.plainView.bounds.height)!)
        dropdown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.select1 = arr[index]
            self.zoneButton.setTitle(arr[index], for: .normal)
            
            
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
    
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if(contentMessage.text == "nội dung tin nhắn..."){
            contentMessage.text = ""
            contentMessage.textColor = UIColor.black
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(contentMessage.text.characters.count == 0){
            contentMessage.textColor = UIColor.darkGray
            contentMessage.text = "nội dung tin nhắn..."
            contentMessage.resignFirstResponder()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count // for Swift use count(newText)
        return numberOfChars < 25;
    }
    
}
