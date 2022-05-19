//
//  AddAddressModel.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 29/04/22.
//

import Foundation


struct AddAddressModel: Encodable{
    let userId: String?
    let fullName: String?
    let mobileNo: String?
    let area: String?
    let buildingNo: String?
    let city: String?
    let state: String?
    let pinCode: String?
    let street: String?
    let isdefault: Bool?
}
