//
//  UIView+Extension.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension UIView {
    // base func 
    
    static func nib() -> UINib {
        return UINib(nibName: nibName(), bundle: nil)
    }
    
    static func nibName() -> String {
        return String(describing: self)
    }
    
    static func fromNib() -> UIView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)!.first as! UIView
    }
}
