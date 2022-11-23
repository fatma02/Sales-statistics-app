//
//  UIView+Extensions.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import UIKit

extension UIView {
    /**
     To set corner Radius from storyboard pannel in easy way
     */
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /**
     To set border color from storyboard pannel in easy way
     */
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    /**
     To set border width from storyboard pannel in easy way
     */
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /**
     To apply shadow to uiview
     */
    func applyShadow(radius: CGFloat, color: UIColor, opacity: Float, shadowOffset: CGSize = CGSize(width: -1, height: -1)) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.clipsToBounds = false
        self.layer.shadowOffset = shadowOffset
    }

    /**
     Invoked to add animation to view to notice users for errors
     */
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
