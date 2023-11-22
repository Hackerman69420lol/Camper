//
//  EventCategoryModel.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/21/23.
//

import Foundation

struct EventCategoryModel: Identifiable, Hashable {
    var id: UUID = .init()
    var icon: String
    var title: String
}

var eventCategoryList: [EventCategoryModel] = [
    EventCategoryModel(icon: "infinity", title: "All"),
    EventCategoryModel(icon: "graduationcap.fill", title: "School"),
    EventCategoryModel(icon: "trophy.fill", title: "Tournaments"),
    EventCategoryModel(icon: "party.popper.fill", title: "Parties"),
    EventCategoryModel(icon: "basketball.fill", title: "Sports"),
    EventCategoryModel(icon: "figure.2.arms.open", title: "Communities"),
]
