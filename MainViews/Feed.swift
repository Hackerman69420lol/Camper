//
//  Home .swift
//  letsgetrich
//
//  Created by Michael Washington on 9/9/23.
//

import SwiftUI

struct Feed: View {
    @EnvironmentObject var postData : PostData
    var body: some View {
        NavigationStack {
    
            PostListView()
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
                .environmentObject(PostData())

        }
    }
}
