//
//  ViewModel.swift
//  AuthorizationApp
//
//  Created by piggyback13 on 25.02.2023.
//

import Foundation

class LoginViewModel {
    
    var status = Dynamic("")
    var isLoggedIn = false
    
    func logIn(login: String, password: String) {
        if login != User.logins[0].login || password != User.logins[0].password {
            status.value = "Login failed"
            isLoggedIn = false
        } else {
            status.value = ""
            isLoggedIn = true
        }
    }

}
