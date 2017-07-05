//
//  Utils.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class Util {
    static func showAlert(title: String?, message: String?, cancelAction: ((UIAlertAction) -> Void)?) {
        let alertViewC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: cancelAction)
        alertViewC.addAction(cancelAction)
        (UIApplication.shared.delegate as! AppDelegate).getCurrentViewController().present(alertViewC, animated: true, completion: nil)
    }
}
