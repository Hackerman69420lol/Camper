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
            
            PostListView()
            
            
                .refreshable {
                    print("DEBUG: Refresh OnCamp")
                }
                .navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.inline)
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
