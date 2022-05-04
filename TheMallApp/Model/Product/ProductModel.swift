//
//  ProductModel.swift
//  TheMallApp
//
//  Created by M1 on 09/04/22.
//

import UIKit

class ProductModel: NSObject {
    let id : String? = nil
    let name: String? = nil
    let productDescription: String? = nil
    let mastrPrice: Int? = 0
    let productUrl: String? = nil
    let banner: String? = nil
    let store: String? = nil
    let size: productSize? = nil
    let features: features? = nil
    let gallery: productGallery? = nil
}


class productSize: NSObject{
    let id: String? = nil
    let value: String? = nil
    let price: String? = nil
}

class features: NSObject{
    let id: String? = nil
    let key: String? = nil
    let value: String? = nil
}

class productGallery: NSObject{
    let name: String? = nil
    let createdAt: String? = nil
    let id: String? = nil
}
