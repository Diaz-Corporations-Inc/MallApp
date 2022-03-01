//
//  SignUPModel.swift
//  TheMallApp
//
//  Created by mac on 23/02/2022.
//

import Foundation

struct signUpModel: Encodable {
    let email: String?
    let password: String?
    let name: String?
    let dob: String?
}

struct  loginModel: Encodable {
    let email: String?
    let password: String?
}

struct  forgotPassword: Encodable {
    let email: String?
}

struct changePassModel: Encodable {
    let oldPassword: String?
    let newPassword:String?
}
