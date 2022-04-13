//
//  ApiUrls.swift
//  TheMallApp
//
//  Created by mac on 23/02/2022.
//

import Foundation

public var baseUrl = "http://93.188.167.68:8004/api/"
    
public struct Api{
    
//MARK: - user api urls
    
    public static var signUp                     = baseUrl + "users/create"
    public static var login                      = baseUrl + "users/login"
    public static var forgot                     = baseUrl + "users/forgotPassword"
    public static var otp                        = baseUrl + "users/otpVerify"
    public static var reset                      = baseUrl + "users/changePassword"
    public static var changePass                 = baseUrl + "users/resetPassword/"
    public static var profileImage               = baseUrl + "users/profileImageUpload/"
    
//MARK: - STORE api urls
    public static var createStore                = baseUrl + "store/create"
    public static var storeList                  = baseUrl + "store/list"
    public static var storeById                  = baseUrl + "store/getStoreById/"
    public static var storeImage                 = baseUrl + "store/imageUpload/"
    public static var myStore                    = baseUrl + "store/myStores/"
   
//MARK: - favourite api's
    public static var favUnfav                   = baseUrl + "store/makeFavOrUnfav"
    public static var getFav                     = baseUrl + "store/favList/"
    public static var getProfile                 = baseUrl + "users/getUserById/"
    
//MARK: - products api's
    public static var getProduct                 = baseUrl + "products/getProducts"
    public static var getProductById             = baseUrl + "products/getProductById/"
    public static var myStoreProducts            = baseUrl + "products/byStoreId/"
    public static var addProduct                 = baseUrl + "products/add"
    public static var addProductImages           = baseUrl + "products/imageUpload/"
    
// MARK: - cart api's
    public static var addToCart                  = baseUrl + "carts/addToCart"
    public static var getCart                    = baseUrl + "carts/getCarts"
    public static var deleteCart                 = baseUrl + "carts/deleteItem/"
}
