//
//  RegistrationDetails.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 11/3/21.
//

import Foundation
struct RegistrationDetails {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var city: String
}

extension RegistrationDetails {
static var new: RegistrationDetails {
//copy the code below from RegistrationViewModel
    RegistrationDetails(
        email: "",
        password: "",
        firstName: "",
        lastName: "",
        city: "")
    }
}
