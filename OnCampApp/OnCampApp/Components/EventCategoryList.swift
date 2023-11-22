//
//  EventCategoryList.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/21/23.
//

import SwiftUI

struct EventCategoryList: View {
    @State var selectedCategory = "All"
    let eventcategories = eventCategoryList // Use the array of CategoryModel instances you've provided.

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(eventcategories) { item in
                    Button(action: {
                        selectedCategory = item.title
                    }) {
                        HStack {
                            if item.title != "All" {
                                Image(systemName: item.icon) //
                                    .foregroundColor(selectedCategory == item.title ? .blue : .black)
                            }
                            Text(item.title)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(selectedCategory == item.title ? .black : .gray.opacity(0.1))
                        .foregroundColor(selectedCategory != item.title ? .black : .white)
                        .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct EventCategoryList_Previews: PreviewProvider {
    static var previews: some View {
        EventCategoryList()
    }
}
