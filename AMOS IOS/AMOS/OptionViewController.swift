//
//  OptionViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI
import SnapKit

class OptionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Input properties
    var id: Int!
    var currentDevice: Device!
    
    @IBOutlet weak var datePickerContainerBottom: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var containerView: UIView!
    fileprivate let hourPicker = CustomDatePicker.fromNib() as! CustomDatePicker
    
    lazy var data: [String] = {
        return [
            "THAY ĐỔI MẬT KHẨU",
            "CÀI ĐẶT KHOÁ PHÍM",
            "THAY ĐỔI NỘI DUNG SMS",
            "CÀI ĐẶT TRẠNG THÁI CHO CÁC VÙNG",
            "CÀI ĐẶT ÂM LƯỢNG CÒI BÁO ĐỘNG",
            "CÀI ĐẶT CẢM BIẾN CÓ DÂY",
            "CÀI ĐẶT ĐỘ TRỄ TRUNG TÂM",
            "CÀI ĐẶT ĐỘ TRỄ CẢM BIẾN"
        ]
    }()
    
    lazy var phoneSetting: [String] = {
        return [
            "CÀI ĐẶT SĐT GỌI ĐẾN",
            "CÀI ĐẶT TIN NHẮN ĐẾN"
        ]
    }()
    
    lazy var timeSetting: [String] = {
        return [
            "CÀI ĐẶT THỜI GIAN THỰC",
            "CÀI ĐẶT NHÓM THỜI GIAN TỰ ĐỘNG TẮT MỞ",
            "CÀI ĐẶT VÙNG TẮT MỞ",
            "HUỶ CÀI ĐẶT"
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        currentDevice = RealmManager.getCurrentDevice(id: id)
    }
    
    // MARK: Actions
    @IBAction func donePressed(_ sender: UIButton) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyymmddhhmmss"
        
        let stringDate = timeFormatter.string(from: datePicker.date)
        let index = stringDate.index(stringDate.startIndex, offsetBy: 2)
        
        let otherBody = currentDevice.type == 0 ? stringDate.substring(to: index) : "\(currentDevice.password)56\(stringDate)#"
        
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        let device4String = timeFormatter.string(from: datePicker.date).components(separatedBy: ":").first
        
        createMessage(device4: device4String!, otherDevice: otherBody)
        hideDatePicker()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        hideDatePicker()
    }
}

// MARK: Datasoure, delegate
extension OptionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return phoneSetting.count
        case 1:
            return timeSetting.count
        case 2:
            return data.count
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "CÀI ĐẶT SĐT"
        case 1:
            return "CÀI ĐẶT TẮT MỞ THEO THỜI GIAN"
        default:
            break
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "callnumber") as! CallNumberSettingViewController
                vc.id = id
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                if currentDevice.type == 3 {
                    Util.showAlert(title: "Thông báo", message: "Vui lòng thao tác trên thiết bị trung tâm", cancelAction: nil)
                } else {
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "smsnumber") as! SmsNumberSettingViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                if currentDevice.type == 3 {
                    Util.showAlert(title: "Thông báo", message: "Vui lòng thao tác trên thiết bị trung tâm", cancelAction: nil)
                } else {
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "installAuto") as! IntallAutoauthorViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
            case 1:
                let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "automatic") as! AutomaticViewController
                vc.id = id
                navigationController?.pushViewController(vc, animated: true)
            case 2:
                
                if currentDevice.type == 3 {
                    
                    Util.showAlert(title: "Thông báo", message: "Vui lòng thao tác trên thiết bị trung tâm", cancelAction: nil)
                    
                } else {
                    
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "zonesetting") as! ZoneSettingViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            case 3:
                
                if(currentDevice.type != 3){
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "cancelzone") as! CancelSettingViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                    
                }
                else{
                    
                     Util.showAlert(title: "Thông báo", message: "thao tác trên cài đặt nhóm thời gian tự động tắt mở", cancelAction: nil)
                }
              
                
            default:
                break
            }
        case 2:
            switch indexPath.row {
                
            case 0:
                if (currentDevice.type == 3){
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "passwordDevice4") as! ChangePassWordDevice4ViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "changepass") as! ChangePassWordViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
                
            case 1:
                if currentDevice.type == 3 {
                    Util.showAlert(title: "Thông báo", message: "Vui lòng thao tác trên thiết bị trung tâm", cancelAction: nil)
                } else {
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "lockkeyboard") as! LockKeyboardViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
            case 2:
                if currentDevice.type == 3 {
                    let vc = UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: "changemessagepage") as! ChangeMessagePageViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "changemessage") as! ChangeMessageViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
            case 3:
                if currentDevice.type == 3 {
                    let vc = UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: "statussettingpage") as! StatusSettingPageViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "statussetting") as! StatusSettingViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
            case 4:
                let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "volumesetting") as! VolumeSettingViewController
                vc.id = id
                navigationController?.pushViewController(vc, animated: true)
            case 5:
                if currentDevice.type == 3 || currentDevice.type == 0{
                    Util.showAlert(title: "Thông báo", message: "Vui lòng thao tác trên thiết bị trung tâm", cancelAction: nil)
                } else {
                    let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "availablesetting") as! AvalibleSettingViewController
                    vc.id = id
                    navigationController?.pushViewController(vc, animated: true)
                }
            case 6:
                let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "delayavailablesetting") as! DelayValiableViewController
                vc.type = 10
                vc.id = id
                navigationController?.pushViewController(vc, animated: true)
            case 7:
                let vc = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "delayavailablesetting") as! DelayValiableViewController
                vc.type = 11
                vc.id = id
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = phoneSetting[indexPath.row]
        case 1:
            cell.textLabel?.text = timeSetting[indexPath.row]
        default:
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
}


// MARK: Methods
extension OptionViewController: MFMessageComposeViewControllerDelegate {
    fileprivate func setupView() {
        
    }
    
    fileprivate func setupDatePicker() {
        datePicker.datePickerMode = .dateAndTime
    }
    
    fileprivate func showDatePicker() {
        datePickerContainerBottom.constant = 0
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func hideDatePicker() {
        datePickerContainerBottom.constant = -250
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func createMessage(device4: String, otherDevice: String) {
        let messageVC = MFMessageComposeViewController()
        
        let realm = try! Realm()
        
        let currentDevice = realm.object(ofType: Device.self, forPrimaryKey: id)
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
