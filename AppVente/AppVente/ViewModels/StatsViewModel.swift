//
//  StatsViewModel.swift
//  AppVente
//
//  Created by Fatma Fitouri on 23/11/2022.
//

import Foundation
import FirebaseDatabase

class StatsViewModel {
    static var shared = StatsViewModel()

    func getBrandStats(brandKey: String, completion: @escaping (_ list: [Purchase]) -> Void) {
        let databaseRef = Database.database().reference().child("conversions/purchase")
        let query = databaseRef.queryOrdered(byChild: "brandKey").queryStarting(atValue: brandKey).queryEnding(atValue: "\(brandKey)\\uf8ff")
        query.observeSingleEvent(of: .value) { snapshot in
            guard let values = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            let list = values.map({ Purchase(values: $0.value as? [String: Any] ?? [:]) })
            completion(list)
        }
    }
}
