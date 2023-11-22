//
//  SideMenuOptions.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/16/23.
//

import SwiftUI

struct SideMenuOptions: View {
    var body: some View {
        NavigationStack{
            VStack{
                HStack(spacing: 16) {
                    Image(systemName: "v.circle.fill")
                        .frame(width: 24, height: 24)
                    
                    NavigationLink(destination: BecomeVendorView(), label: {
                        Text ("Become a Vendor!")
                    })
                    
                    Spacer()
                }
                .foregroundColor(Color(.white))
                
                Spacer()
                
                HStack(spacing: 16) {
                    Image(systemName: "bag.fill")
                        .frame(width: 24, height: 24)
                    
                    NavigationLink(destination: MyOrdersView(), label: {
                        Text ("My Orders")
                    })
                    
                    Spacer()
                }
                .foregroundColor(Color(.white))
                
                Spacer()
                
                HStack(spacing: 16) {
                    Image(systemName: "storefront.fill")
                        .frame(width: 24, height: 24)
                    
                    NavigationLink(destination: VendorHub(), label: {
                        Text ("Go To VendorHub")
                    })
                    
                    Spacer()
                }
                .foregroundColor(Color(.white))
                
                Spacer()
                
                Spacer()
            }
        }
    }
}

struct SideMenuOptions_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptions()
    }
}
