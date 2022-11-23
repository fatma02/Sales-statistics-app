//
//  String+Extensions.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import Foundation

extension String {

    /**
     To verify if a string is a valid email
     */
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
