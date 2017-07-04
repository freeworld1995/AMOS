//
//  FormAcountViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import DropDown
class FormAcountViewController: UIViewController, UITextFieldDelegate {

    let dropdown = DropDown()
    var deviceIndex = 0
    
    @IBOutlet var dropDown: UIButton!
    
    @IBOutlet var tenThietBi: UITextField!
    
    @IBOutlet var soSimTrungTam: UITextField!
    
    @IBOutlet var matKhau: UITextField!
    
    let arrayName = ["AM-3800G","AM-6800G","AM-GSM74/GSM74I","AM-KS999"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropdown.anchorView = dropDown
        dropdown.dataSource = arrayName
        dropdown.bottomOffset = CGPoint(x: 0, y:(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.dropDown.setTitle(self.arrayName[index], for: .normal)
            self.deviceIndex = index
            if self.deviceIndex == 3 {
                self.matKhau.text = "888888"
            }
            else {
                self.matKhau.text = "1234"
            }
            
        }
        
        matKhau.delegate = self
        if self.deviceIndex == 3 {
            matKhau.text = "888888"
        }
        else {
            matKhau.text = "1234"
        }
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))

        view.addGestureRecognizer(tap)
        
        
    }

    @IBAction func dropdownPressed(_ sender: UIButton) {
        dropdown.show()
    }
    
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        var length = 0
        if self.deviceIndex == 3 {
           length = 6
        }
        else {
            length = 4
        }

        return newLength <= length
    }
    
    
    @IBAction func Save(_ sender: Any) {
        
        if(tenThietBi.text != "" && soSimTrungTam.text != ""){
            
            // Save to Realm
            
            RealmManager.saveDevice(name: tenThietBi.text!, type: deviceIndex, device: "", SIM: soSimTrungTam.text!, password: matKhau.text!)
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
    }

}
