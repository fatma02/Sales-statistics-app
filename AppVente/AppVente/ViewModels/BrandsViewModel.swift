//
//  BrandsViewModel.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import Foundation
import FirebaseDatabase

class BrandsViewModel {
    static var shared = BrandsViewModel()

    func getBrandsList(completion: @escaping (_ premium: [Brand], _ other: [Brand], _ new: [Brand]) -> Void) {
        Database.database().reference().child("brands").observe(.value, with: { snapshot in
            guard let values = snapshot.value as? [String: Any] else {
                completion([], [], [])
                return
            }
            let brands = values.map({ Brand(values: $0.value as? [String: Any] ?? [:]) })
            var new = [Brand]()
            var premium = [Brand]()
            var other = [Brand]()
            for brand in brands {
                if brand.isNew == true {
                    new.append(brand)
                }
                if brand.premium == true {
                    premium.append(brand)
                } else {
                    other.append(brand)
                }
            }
            completion(premium, other, new)
        })
    }
}
