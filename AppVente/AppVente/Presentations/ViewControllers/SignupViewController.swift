//
//  SignupViewController.swift
//  AppVente
//
//  Created by Fatma Fitouri on 22/11/2022.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class SignupViewController: UIViewController {

    @IBOutlet private weak var loader: NVActivityIndicatorView!
    @IBOutlet private weak var signupButton: UIButton!
    @IBOutlet private weak var pwdTextField: UITextField!
    @IBOutlet private weak var confirmPwdTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.applyShadow(radius: 3, color: .lightGray, opacity: 0.4)
    }

    @IBAction private func signinButtonDidClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func signupButtonDidClicked(_ sender: UIButton) {
        sender.isEnabled = false
        view.endEditing(true)
        guard let email = emailTextField.text, email.isValidEmail() else {
            print("Invalid Email")
            emailTextField.shake()
            emailTextField.becomeFirstResponder()
            sender.isEnabled = true
            return
        }
        guard let pwd = pwdTextField.text, pwd.count >= 6 else {
            print("Short password")
            pwdTextField.shake()
            pwdTextField.becomeFirstResponder()
            sender.isEnabled = true
            return
        }
        guard let confirmPwd = confirmPwdTextField.text, pwd == confirmPwd else {
            print("Different passwords")
            confirmPwdTextField.shake()
            confirmPwdTextField.becomeFirstResponder()
            sender.isEnabled = true
            return
        }
        loader.startAnimating()
        authenticateUser(email: email, pwd: pwd)
    }

    func authenticateUser(email: String, pwd: String) {
        AuthViewModel.shared.signupUser(email: email, pwd: pwd) { [weak self] error in
            guard let self = self else { return }
            self.signupButton.isEnabled = true
            self.loader.stopAnimating()
            if let error = error {
                self.showBasicAlert(title: "Error", message: error)
            } else {
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                self.present(mainVC!, animated: true, completion: nil)
            }
        }
    }
}
