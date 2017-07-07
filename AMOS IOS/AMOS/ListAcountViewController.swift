//
//  ListAcountViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
class ListAcountViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addAcount: UIButton!

    var devices : [Device]! = nil
    let realm = try! Realm()
    @IBAction func addAcount(_ sender: Any) {
        
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "formacount") as! FormAcountViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = realm.objects(Device.self)
        self.devices = Array(result)
        
        addAcount.layer.cornerRadius = 10;
        addAcount.layer.borderWidth = 2;
        addAcount.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let result = realm.objects(Device.self)
        self.devices = Array(result)
        self.tableView.reloadData()
    }


}


extension ListAcountViewController{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellistacount", for: indexPath)
        cell.textLabel?.text = devices[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // didselec
        
        let story = UIStoryboard.init(name: "Main2", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "pages") as! PageViewController
        vc.id = devices[indexPath.row].id
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            RealmManager.deleteDevice(id: devices[indexPath.row].id)
            devices.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}



