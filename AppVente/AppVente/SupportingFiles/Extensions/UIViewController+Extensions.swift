//
//  UIViewController+Extensions.swift
//  AppVente
//
//  Created by Fatma Fitouri on 23/11/2022.
//

import UIKit

extension UIViewController {
    func showBasicAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
