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
    public static var updateStore                = baseUrl + "store/update/"
   
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
    public static var updateProduct              = baseUrl + "products/update/"
    public static var ratingReview               = baseUrl + "products/ratingReview"
//
        
// MARK: - cart api's
    public static var addToCart                  = baseUrl + "carts/addToCart"
    public static var getCart                    = baseUrl + "carts/getCarts"
    public static var deleteCart                 = baseUrl + "carts/deleteItem/"

//MARK: - address
    public static var addAddress                 = baseUrl + "addresses/create"
    public static var getAddress                 = baseUrl + "addresses/byUser/"
    public static var updateAddress              = baseUrl + "addresses/update/"
    public static var addressById                = baseUrl + "addresses/byId/"
//MARK: - Categories
    public static var getCategories              = baseUrl + "categories/getCategories"
//MARK: - SEARCH API
    public static var search                     = baseUrl + "store/search?name="
}
