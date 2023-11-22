//
//  Marketplace.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//

import SwiftUI

struct Marketplace: View {
    @State private var showingMenu = false
    @State var selectedCategory = "AUCS"
    var vendorList: [Vendor]
    
    var body: some View {
        NavigationStack{
            ZStack {
                if showingMenu {
                    SideMenu(showingMenu: $showingMenu)
                }
                    ScrollView {
                        VStack{
                            
                            HStack{
                                Spacer()
                                
                                Spacer()
                                
                                HStack{
                                    Text("Vendor")
                                        .foregroundColor(.blue)
                                        .padding(.trailing, -8.0)
                                    Text("Hub")
                                }
                                .font(.title)
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.spring()) {
                                        showingMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.3.horizontal")
                                    
                                }
                                .font(.system(size: 30))
                                .padding(30)
                                
                            }
                            //Category List
                            CategoryList()
                            
                            //Trending Vendors
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
                            
                            Divider()
                            
                            HStack {
                                
                                Text("Hair Stylists")
                                    .font(.system(size: 24))
                                
                                Spacer()
                                
                                
                            }
                            .padding(.horizontal,30)
                            .padding(.vertical,15)
                            
                            // Vendor List
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(vendorList, id: \.id) { vendor in // Make sure Vendor conforms to Identifiable
                                        
                                        SmallVendorCard(vendor: vendor)
                                        
                                    }
                                }
                                .padding(.horizontal, 30)
                            }
                        }
                    }
                    .offset(x: showingMenu ? 300 : 0, y:0)
                }
            }
        }
    
    struct MaketplaceHome: View {
        var body: some View{
            NavigationStack{
                
            }
        }
    }
    
}
struct Marketplace_Previews: PreviewProvider {
    static var previews: some View {
        Marketplace(vendorList: vendorList)
    }
}
