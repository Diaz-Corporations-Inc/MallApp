//
//  PaymentModel.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 01/06/22.
//

import Foundation

struct PaymentModel: Encodable{
    let userId: String?
    let amount: Double?
    let currency: String?
    let source: String?
}
