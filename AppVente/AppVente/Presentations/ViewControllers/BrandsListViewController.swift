//
//  BrandsListViewController.swift
//  AppVente
//
//  Created by Fatma Fitouri on 21/11/2022.
//

import Hero
import UIKit
import SDWebImage
import FirebaseAuth
import NVActivityIndicatorView

class BrandsListViewController: UIViewController {

    @IBOutlet private weak var carrousselHeight: NSLayoutConstraint!
    @IBOutlet private weak var carroussel: UICollectionView!
    @IBOutlet private weak var loader: NVActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private var typeButtons: [UIButton]!
    @IBOutlet private weak var indicatorView: UIView!

    var lastScrollPosition: CGFloat = 0.0

    var selectedType = 0
    var new = [Brand]()
    var premium = [Brand]()
    var other = [Brand]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let height: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 80 : 120
        carrousselHeight.constant = height
        if let layout = carroussel.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: height, height: height)
        }
        typeButtons.forEach({ $0.setTitleColor(UIColor(named: "AccentColor"), for: .selected) })
        getBrands()
    }

    func getBrands() {
        loader.startAnimating()
        BrandsViewModel.shared.getBrandsList { [weak self] premium, other, new in
            guard let self = self else { return }
            self.loader.stopAnimating()
            self.premium = premium
            self.other = other
            self.new = new
            self.collectionView.reloadData()
            self.carroussel.reloadData()
            self.carroussel.isHidden = new.isEmpty
        }
    }

    @IBAction private func typeButtonDidClicked(_ sender: UIButton) {
        guard !sender.isSelected else { return }
        selectedType = sender.tag
        typeButtons.forEach({ $0.isSelected = sender.tag == $0.tag })
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.indicatorView.center = CGPoint(x: sender.center.x, y: 38)
        }
        collectionView.reloadData()
    }

    @IBAction private func logoutButtonDidClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UIApplication.shared.connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }?.rootViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }

    @IBAction private func carrousselItemDidClicked(_ sender: UIButton) {
        let statsVC = storyboard?.instantiateViewController(withIdentifier: "statisctics") as? StatiscticsViewController
        statsVC?.brand = new[sender.tag]
        statsVC?.heroId = "new\(new[sender.tag].key)"
        self.show(statsVC!, sender: nil)
    }
}

extension BrandsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? selectedType == 0 ? premium.count : other.count : new.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ImageCollectionViewCell
        let brand = (collectionView.tag == 0 ? selectedType == 0 ? premium : other : new)[indexPath.item]
        cell?.setCellContent(url: brand.pic, tag: indexPath.item)
        cell?.heroID = collectionView.tag == 1 ? "new\(brand.key)" : brand.key
        return cell!
    }
}

extension BrandsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let statsVC = storyboard?.instantiateViewController(withIdentifier: "statisctics") as? StatiscticsViewController
        statsVC?.brand = (selectedType == 0 ? premium : other)[indexPath.item]
        self.show(statsVC!, sender: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !new.isEmpty else { return }
        carroussel.isHidden = scrollView.contentOffset.y >= lastScrollPosition
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !new.isEmpty else { return }
        lastScrollPosition = scrollView.contentOffset.y
    }
}

extension BrandsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberItemPerRow: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 5
        let width = (UIScreen.main.bounds.width - 50 - ((numberItemPerRow - 1) * 10)) / numberItemPerRow
        return CGSize(width: width, height: width)
    }
}
