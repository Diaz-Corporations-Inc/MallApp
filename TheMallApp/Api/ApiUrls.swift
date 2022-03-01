//
//  ApiUrls.swift
//  TheMallApp
//
//  Created by mac on 23/02/2022.
//

import Foundation

public var baseUrl = "http://93.188.167.68:8004/api/"

public struct Api{
    
    public static var signUp                     = baseUrl + "users/create"
    public static var login                      = baseUrl + "users/login"
    public static var forgot                     = baseUrl + "users/forgotPassword"
    public static var otp                        = baseUrl + "users/otpVerify"
    public static var reset                      = baseUrl + "users/changePassword"
    public static var changePass                 = baseUrl + "users/resetPassword/"
    public static var profileImage               = baseUrl + "users/profileImageUpload/"
    public static var profile                    = baseUrl + "users/profileImageUpload/"


}
