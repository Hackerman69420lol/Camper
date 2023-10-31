//
//  Search.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/13/23.
//

import SwiftUI

struct Search: View {
    
    var body: some View {
        NavigationStack {
            HStack{
                Image(systemName: "magnifyingglass")
                
                VStack(alignment: .leading, spacing: 2){
                    Text("Search")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundStyle(.black)
                })
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay {
                Capsule()
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(Color(.systemGray4))
                    .shadow(color: .black.opacity(0.4),radius: 2)
            }
            .padding()
          
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
