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
    dynamic var name = ""
    dynamic var device = ""
    dynamic var SIM = ""
    dynamic var password = ""
    
    convenience init(name: String, device: String, SIM: String, password: String) {
        self.init()
        self.name = name
        self.device = device
        self.SIM = SIM
        self.password = password
    }
}
