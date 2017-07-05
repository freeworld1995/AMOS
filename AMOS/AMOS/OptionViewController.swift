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
    
    lazy var data: [String] = {
        return [
            "CÀI ĐẶT SĐT",
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: Datasoure, delegate
extension OptionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
}

// MARK: Methods
extension OptionViewController {
    
}
