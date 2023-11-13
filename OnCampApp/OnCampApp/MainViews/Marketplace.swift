//
//  Marketplace.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//

import SwiftUI

struct Marketplace: View {
    @State var selectedCategory = "AUCS"
    var vendorList: [Vendor]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    HStack{
                        Spacer()
                        
                        Spacer()
                        
                        Text("Vendor")
                            .foregroundColor(.blue)
                            .padding(.trailing, -8.0)
                        Text("Hub")
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .padding()
                    }
                    .font(.system(size: 30))
                    .padding(30)
                    
                }
                //Category List
                CategoryList()
                
                //Collections View
                HStack {
                    
                    Text("Trending Vendors")
                        .font(.system(size: 24))
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal,30)
                .padding(.vertical,15)
                
                // Vendor List
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vendorList, id: \.id) { vendor in // Make sure Vendor conforms to Identifiable
                            
                            VendorCard(vendor: vendor)
                            
                        }
                    }
                    .padding(.horizontal, 30)
                }
                
            }
        }
    }
}
struct Marketplace_Previews: PreviewProvider {
    static var previews: some View {
        Marketplace(vendorList: vendorList)
    }
}
