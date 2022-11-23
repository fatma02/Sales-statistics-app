//
//  AuthViewModel.swift
//  AppVente
//
//  Created by Fatma Fitouri on 23/11/2022.
//

import FirebaseAuth

class AuthViewModel {
    static var shared = AuthViewModel()

    func signinUser(email: String, pwd: String, completion: @escaping (_ error: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pwd) { authResult, error in
            completion(authResult == nil ? error?.localizedDescription : nil)
        }
    }

    func signupUser(email: String, pwd: String, completion: @escaping (_ error: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pwd) { authResult, error in
            completion(authResult == nil ? error?.localizedDescription : nil)
        }
    }
}
