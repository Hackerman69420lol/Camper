//
//  FavoriteVendorsView.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/15/23.
//

import SwiftUI

struct VendorHub: View {
    @Environment(\.presentationMode) var mode
    

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "house")
                                .imageScale(.small)
                                .padding()
                                .frame(width: 50, height: 90)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                        }
                        
                        Spacer()
                        
                        // Displaying the vendor's store name
                        Text("Store Name")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                            
                        
                        Spacer()
                        
                        Button {
                            Text("Add Item")
                        } label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 50, height: 90)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                        }
                    }
                    .padding(30)
                    
                    // Grid of products
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                        ForEach(productList, id: \.id) { item in
                            VendorSmallProductCard(product: item)
                        }
                    })

                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
struct VendorHub_Previews: PreviewProvider {
    static var previews: some View {
        VendorHub()
    }
}

