//
//  File.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 27/04/22.
//

import Foundation


struct ReviewModel: Encodable{
    let userId: String?
    let productId: String?
    let rating: Int?
    let review: String?
    let customerName: String?
}
