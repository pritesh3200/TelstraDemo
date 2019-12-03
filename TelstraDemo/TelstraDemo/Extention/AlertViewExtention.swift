//
//  AlertViewExtention.swift
//  TelstraDemo
//
//  Created by Pritesh on 02/12/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
