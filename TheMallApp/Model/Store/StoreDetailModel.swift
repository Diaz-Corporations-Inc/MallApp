//
//  StoreDetailModel.swift
//  TheMallApp
//
//  Created by M1 on 09/04/22.
//

import UIKit

struct storeDetailModel: Encodable{
    let timing : timing?
    let priceRange :price?
    let location :loc?
    let gallery: gallery?
    let slogan: String?
    let logo: String?
    let banner: String?
    let webSiteUrl: String?
    let city: String?
    let scotNo:  String?
    let  state:  String?
    let  landmark:  String?
    let contactNo: String?
    let zipCode:  String?
    let storeId: String?
    let name : String?
    let userId: String?
    let description: String?
    let createdAt : String?
    let updatedAt: String?
}

struct timing: Encodable{
    let to: String?
    let from: String?
}

struct price: Encodable{
    let to: String?
    let from: String?
}

struct loc: Codable{
    let coordinates: [Double]?
}

struct gallery: Encodable{
    let name: String?
    let updatedAt: String?
    let id: String?
}
