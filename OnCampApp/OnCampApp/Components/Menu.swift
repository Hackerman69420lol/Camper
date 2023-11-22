//
//  Menu.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/15/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                NavigationLink("Become a Vendor", destination: BecomeVendorView())
                
                Spacer()
            }
            VStack{
                Divider()
                
                Spacer()
                
                NavigationLink("Go to VendorHub", destination: VendorHub())
                
                Spacer()
            }
            VStack{
                Divider()
                
                Spacer()
                
                NavigationLink("My Orders", destination: MyOrdersView())
                
                Spacer()
                
                Divider()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
