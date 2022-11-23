//
//  Brand.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import Foundation

struct Brand {

    var key: String
    var offerId: Int
    var name: String
    var description: String
    var pic: String
    var premium: Bool
    var isNew: Bool

    init(values: [String: Any]) {
        key = values["key"] as? String ?? ""
        offerId = values["offerId"] as? Int ?? 0
        name = values["name"] as? String ?? ""
        description = values["description"] as? String ?? ""
        pic = values["pic"] as? String ?? ""
        premium = values["premium"] as? Bool ?? false
        isNew = values["isNew"] as? Bool ?? false
    }
}
