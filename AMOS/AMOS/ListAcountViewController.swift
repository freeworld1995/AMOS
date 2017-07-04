//
//  ListAcountViewController.swift
//  AMOS
//
//  Created by VanQuang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class ListAcountViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addAcount: UIButton!

    @IBAction func addAcount(_ sender: Any) {
        
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "formacount") as! FormAcountViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        addAcount.layer.cornerRadius = 10;
        addAcount.layer.borderWidth = 2;
        addAcount.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension ListAcountViewController{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellistacount", for: indexPath)
        cell.textLabel?.text = "aaaaa"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // didselec
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            // array Acount --
            
//            yourArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}



