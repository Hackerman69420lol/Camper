//
//  CategoryModel.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import Foundation

struct CategoryModel: Identifiable, Hashable {
    var id: UUID = .init()
    var icon: String
    var title: String
}

var categoryList: [CategoryModel] = [
    CategoryModel(icon: "infinity", title: "All"),
    CategoryModel(icon: "scissors", title: "Hair"),
    CategoryModel(icon: "tshirt.fill", title: "Clothes"),
    CategoryModel(icon: "storefront.fill", title: "Store"),
    CategoryModel(icon: "tree.fill", title: "AUCS"),
]
