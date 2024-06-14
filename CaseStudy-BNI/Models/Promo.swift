//
//  Promo.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 14/06/24.
//

import Foundation

struct PromoResponse: Codable {
    let promos: [Promo]
}

struct Promo: Codable {
    let id: Int
    let name: String
    let imagesUrl: String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imagesUrl = "images_url"
        case detail
    }
}
