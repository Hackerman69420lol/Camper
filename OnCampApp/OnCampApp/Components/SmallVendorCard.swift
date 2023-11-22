//
//  SmallVendorCard.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/15/23.
//

import SwiftUI

struct SmallVendorCard: View {
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
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 70)
                        
                        Text(vendor.category)
                            .font(.callout)
                            .padding()
                            .background(.white.opacity(0.5))
                            .clipShape(Capsule())
                        Spacer()
                        
                        HStack{
                            StarRating(rating: vendor.rating)
                                .padding(.leading,8)
                            
                            Spacer()
                            
                            NavigationLink {
                                Collections()
                                    .navigationBarHidden(true) // If you want to hide the navigation bar
                            } label: {
                                Image(systemName: "arrow.right")
                                    .imageScale(.small)
                            }

                        }
                        .padding(.leading, -30)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(.white.opacity(0.8))
                        .clipShape(Capsule())
                        
                    })
                }
                .padding(20)
                .frame(width: 170, height: 215)
            }
            .frame(width: 170, height: 215)
            .background(vendor.color.opacity(0.13))
            .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.leading,10)
        }
    }
}

struct SmallVendorard_Previews: PreviewProvider {
    static var previews: some View {
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
        
        SmallVendorCard(vendor: sampleVendor)
    }
}
