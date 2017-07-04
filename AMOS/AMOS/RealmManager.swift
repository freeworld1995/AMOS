//
//  RealmManager.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/4/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    static func saveDevice(name: String, type: Int, device: String, SIM: String, password: String) {
        let device = Device(name: name, type: type, device: device, SIM: SIM, password: password)
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(device)
        }
    }
    
    static func deleteDevice(id: String) {
        let realm = try! Realm()
        
        if let object = realm.object(ofType: Device.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
    
    
}
