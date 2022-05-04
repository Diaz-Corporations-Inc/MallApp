//
//  CartModel.swift
//  TheMallApp
//
//  Created by M1 on 09/04/22.
//

import UIKit

class CartModel: NSObject {
    let status: String? = nil
    let cartId: String? = nil
    let storeId: String? = nil
    let total: Int? = 0
    let quantity: Int? = 0
    let createdOn: String? = nil
    let uodatedOn: String? = nil
    let user: userDatail? = nil
    let product: productData? = nil
    
}

class productData: NSObject{
    let banner: String? = nil
    let productId: String? = nil
    let productName: String? = nil
    let productDescription: String? = nil
    let masterPrice: Int? = 0
    let productUrl: String? = nil
    let storeId: String? = nil
}
class userDatail: NSObject{
    let dob: String? = nil
    let status: String? = nil
    let fcmToken: String? = nil
    let email: String? = nil
    let name: String? = nil
    let profileImageName: String? = nil
}
