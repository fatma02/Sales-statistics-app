//
//  LoginViewController.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class LoginViewController: UIViewController {

    @IBOutlet private weak var loader: NVActivityIndicatorView!
    @IBOutlet private weak var signinButton: UIButton!
    @IBOutlet private weak var pwdTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.applyShadow(radius: 3, color: .lightGray, opacity: 0.4)
    }

    @IBAction private func signinButtonDidClicked(_ sender: UIButton) {
        view.endEditing(true)
        guard let email = emailTextField.text, email.isValidEmail() else {
            print("Invalid Email")
            emailTextField.shake()
            emailTextField.becomeFirstResponder()
            return
        }
        guard let pwd = pwdTextField.text, !pwd.isEmpty else {
            print("Password required")
            pwdTextField.shake()
            return
        }
        authenticateUser(email: email, pwd: pwd)
    }

    func authenticateUser(email: String, pwd: String) {
        loader.startAnimating()
        AuthViewModel.shared.signinUser(email: email, pwd: pwd) { [weak self] error in
            guard let self = self else { return }
            self.loader.stopAnimating()
            self.signinButton.isEnabled = true
            if let error = error {
                self.showBasicAlert(title: "Error", message: error)
            } else {
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                self.present(mainVC!, animated: true, completion: nil)
            }
        }
    }
}
