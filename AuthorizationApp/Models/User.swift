//
//  User.swift
//  AuthorizationApp
//
//  Created by piggyback13 on 25.02.2023.
//

import Foundation

struct User {
    let login: String?
    let password: String?
}

extension User {
    static var logins = [
        User(login: "qwer12", password: "password")
    ]
}

