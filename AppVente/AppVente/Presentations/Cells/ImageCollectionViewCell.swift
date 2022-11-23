//
//  ImageCollectionViewCell.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageview: UIImageView!
    @IBOutlet private weak var selectionButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        applyShadow(radius: 3, color: .lightGray, opacity: 0.4)
    }

    func setCellContent(url: String, tag: Int) {
        imageview.sd_setImage(with: URL(string: url), completed: nil)
        selectionButton?.tag = tag
    }
}
