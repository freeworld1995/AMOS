//
//  Device.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/4/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Foundation
import RealmSwift

class Device: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var type = 0
    dynamic var device = ""
    dynamic var SIM = ""
    dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        
        return (realm.objects(Device.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    convenience init(name: String, type: Int, device: String, SIM: String, password: String) {
        self.init()
        self.id = incrementID()
        self.name = name
        self.type = type
        self.device = device
        self.SIM = SIM
        self.password = password
    }
}
