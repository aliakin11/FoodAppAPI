//
//  CartItemResponse.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 23.01.2025.
//

import Foundation

class CartItemResponse : Codable {
    
    var success: Int?
    var message: String?
    var sepet_yemekler: [CartItem]?
    
}
