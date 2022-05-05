//
//  PlaceOrderModel.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 05/05/22.
//

import UIKit

struct PlaceOrderModel: Encodable{
    let userId: String?
    let addressId: String?
    let totalAmount: String?
    let cart: [cartId]?
}

struct cartId: Codable{
    let cartId:String?
}
