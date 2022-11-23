//
//  StatiscticsViewController.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import Hero
import UIKit
import NVActivityIndicatorView

class StatiscticsViewController: UIViewController {

    @IBOutlet private weak var loader: NVActivityIndicatorView!
    @IBOutlet private weak var salesLabel: UILabel!
    @IBOutlet private weak var commissionLabel: UILabel!
    @IBOutlet private weak var chiffreAffaireLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var brandNameLabel: UILabel!

    var brand: Brand?
    var heroId: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        setBrandDetails()
        getPurchaseList()
    }

    func setBrandDetails() {
        guard let brand = brand else {
            return
        }
        imageView.heroID = heroId ?? brand.key
        imageView.sd_setImage(with: URL(string: brand.pic), completed: nil)
        brandNameLabel.text = brand.name
        descLabel.text = brand.description
    }

    func getPurchaseList() {
        guard let brand = brand else {
            return
        }
        loader.startAnimating()
        StatsViewModel.shared.getBrandStats(brandKey: brand.key) { list in
            self.loader.stopAnimating()
            self.setPurchesInfo(list: list)
        }
    }

    func setPurchesInfo(list: [Purchase]) {
        let commissions = list.reduce(0.0) { $0 + $1.commission }
        let amount = list.reduce(0.0) { $0 + $1.amount }
        commissionLabel.text = "\(commissions.formatPrice) €"
        chiffreAffaireLabel.text = "\(amount.formatPrice) €"
        salesLabel.text = "\(list.count)"
    }
}
