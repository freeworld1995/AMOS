//
//  OptionViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Input properties
    var id: Int!
    var currentDevice: Device!
    
    lazy var data: [String] = {
        return [
            "CÀI ĐẶT THỜI GIAN",
            "THAY ĐỔI MẬT KHẨU",
            "CÀI ĐẶT KHOÁ PHÍM",
            "THAY ĐỔI NỘI DUNG SMS",
            "CÀI ĐẶT TRẠNG THÁI CHO CÁC VÙNG",
            "CÀI ĐẶT ÂM LƯỢNG CÒI HỤ",
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
            "CÀI ĐẶT NHÓM THỜI GIAN TỰ ĐỘNG TẮT MỞ",
            "CÀI ĐẶT VÙNG TẮT MỞ"
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDevice = RealmManager.getCurrentDevice(id: id)
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
extension OptionViewController {
    fileprivate func setupView() {
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
}
