//
//  Purchase.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import Foundation

struct Purchase {
    var offerId: Int
    var createdAt: Int
    var commission: Double
    var amount: Double

    init(values: [String: Any]) {
        offerId = values["offerId"] as? Int ?? 0
        createdAt = values["createdAt"] as? Int ?? 0
        commission = Double(values["commission"] as? String ?? "0.0") ?? 0.0
        amount = values["amount"] as? Double ?? 0.0
    }
}
