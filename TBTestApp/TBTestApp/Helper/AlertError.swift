//
//  AlertError.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation
import UIKit

class AlertError {

    static func showMessage(title: String, msg: String) {

        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(
            title: NSLocalizedString("dialog.ok", comment: ""),
            style: UIAlertAction.Style.default,
            handler: nil)
        alert.addAction(action)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
