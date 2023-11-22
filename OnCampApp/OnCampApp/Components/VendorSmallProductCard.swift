//
//  SmallProductCard.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import SwiftUI

struct VendorSmallProductCard: View {
    var product: Product
    
    var body: some View {
        ZStack {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding(.trailing, -200)
                .rotationEffect(Angle(degrees: 30))
            
            VStack(alignment: .leading) {
                Text("\(product.name)")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 70)
                
                Text("$0") // Category removed, replaced with an empty string
                    .font(.system(size: 10))
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Capsule())
                Spacer()
                
                HStack {
                    Button {
                        // Action for the button
                    } label: {
                        Image(systemName: "trash")
                            .imageScale(.large)
                            .frame(width: 30, height: 30)
                            .background(.black)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    Button {
                        // Action for the button
                    } label: {
                        Image(systemName: "applepencil")
                            .imageScale(.large)
                            .frame(width: 45, height: 40)
                            .background(.black)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, -12)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(.white.opacity(0.8))
                .clipShape(Capsule())
            }
            .padding(20)
            .frame(width: 170, height: 215)
        }
        .frame(width: 170, height: 215)
        .background(product.color.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.leading, 10)
    }
}

struct VendorSmallProductCard_Previews: PreviewProvider {
    static var previews: some View {
        VendorSmallProductCard(product: Product(name: "Sample Product", image: "sample_image", price: 0, color: .gray))
    }
}
