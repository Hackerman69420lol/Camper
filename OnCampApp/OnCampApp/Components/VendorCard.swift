//
//  VendorCard.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/7/23.
//

import SwiftUI

struct VendorCard: View {
    var vendor: Vendor
    
    var body: some View {
        NavigationStack {
            ZStack{
                Image(vendor.image)
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, -200)
                    .rotationEffect(Angle(degrees: 30))
                
                ZStack {
                    VStack(alignment: .leading, content: {
                        Text("\(vendor.name)")
                            .font(.system(size: 36, weight: .semibold))
                            .frame(width: 140)
                        
                        Text(vendor.category)
                            .font(.callout)
                            .padding()
                            .background(.white.opacity(0.5))
                            .clipShape(Capsule())
                        Spacer()
                        
                        HStack{
                            StarRating(rating: vendor.rating)
                            
                            Spacer()
                            
                            NavigationLink {
                                Collections()
                                    .navigationBarHidden(true) // If you want to hide the navigation bar
                            } label: {
                                Image(systemName: "arrow.right")
                                    .imageScale(.large)
                            }

                        }
                        .padding(.leading)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(.white.opacity(0.8))
                        .clipShape(Capsule())
                        
                    })
                }
                .padding(30)
                .frame(width: 336, height: 422)
            }
            .frame(width: 336, height: 422)
            .background(vendor.color.opacity(0.13))
            .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.leading,20)
        }
    }
}

struct VendorCard_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample vendor for the preview
        let sampleVendor = Vendor(
            description: "descript",
            schools: ["d", "e"],
            name: "Vendor One",
            image: "vendorOneImage",
            category: "AUCS",
            rating: 4.5,
            color: .blue,
            products: productList  // Assuming 'productList' is available and contains [Product]
        )
        
        // Use the sample vendor for the preview
        VendorCard(vendor: sampleVendor)
    }
}
