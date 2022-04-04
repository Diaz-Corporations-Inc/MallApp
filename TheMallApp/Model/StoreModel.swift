//
//  StoreModel.swift
//  TheMallApp
//
//  Created by M1 on 16/03/22.
//

import Foundation

struct createStoreModel: Encodable{
    let description: String?
    let userId: String?
    let name : String?
    let slogan: String?
    let webSiteUrl: String?
    let timing : timingModel?
    let priceRange :priceRangeModel?
    let location :locationM?
    let city: String?
    let scotNo:  String?
    let  state:  String?
    let  landmark:  String?
    let zipCode:  String?

}

struct timingModel: Encodable{
    let to: String?
    let from: String?
}


struct priceRangeModel: Encodable{
    let to: String?
    let from: String?
}


struct locationM: Codable{
    let coordinates: [Double]?
}

