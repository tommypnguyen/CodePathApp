//
//  AlertControl.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/17.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Foundation

class AlertControl {
    static let control = AlertControl()
    
    func displayAlert(inVC vc: UIViewController, withTitle title: String, andMsg message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // create and add an OK action to alert controller
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        
        vc.present(alertController, animated: true)
    }
}
