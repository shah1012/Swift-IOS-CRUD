//
//  LoginInCredentials.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 11/10/21.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
