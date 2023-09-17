//
//  Search.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/13/23.
//

import SwiftUI

struct Search: View {
    @State private var searchText = ""

    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0 ... 10, id: \.self) {user in
                        VStack {
                            
                            UserCell()
                            
                            Divider()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
