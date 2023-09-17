//
//  Home .swift
//  letsgetrich
//
//  Created by Michael Washington on 9/9/23.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0 ... 10, id: \.self) {thread in
                        PostCell()
                        
                    }
                }
            }
            .refreshable {
                print("DEBUG: Refresh OnCamp")
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                }label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(Color("LTBL"))
                }
            }
        }
    }
}

struct Feed__Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Feed()
        }
    }
}
