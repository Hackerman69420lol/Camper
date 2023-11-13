//
//  File.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/7/23.
//

import Foundation
import SwiftUI

struct Vendor: Identifiable {
    var id: UUID = .init()
    var name: String
    var image: String
    var category: String
    var rating: Double
    var color: Color
    var products: [Product]  // Assuming `Product` is also a defined type
}

// Assuming `productList` is defined elsewhere and accessible here
var vendorList = [
    Vendor(
        name: "Vendor One",
        image: "vendorOneImage",
        category: "AUCS",
        rating: 4.5,
        color: .blue,
        products: productList
    ),
    // ... other vendors
]
