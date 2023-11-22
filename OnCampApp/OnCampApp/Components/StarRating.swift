//
//  StarRating.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/7/23.
//

import SwiftUI

struct StarRating: View {
    let rating: Double
    var maximumRating: Int = 5
    let onImage = Image(systemName: "star.fill")
    let offImage = Image(systemName: "star")
    let halfImage = Image(systemName: "star.leadinghalf.filled")
    
    func image(for number: Int) -> Image {
        let numberDouble = Double(number)
        if numberDouble <= rating {
            return onImage
        } else if numberDouble - 0.5 <= rating {
            return halfImage
        } else {
            return offImage
        }
    }


    
    var body: some View {
        HStack {
            ForEach(1...maximumRating, id: \.self) { number in
                self.image(for: number)
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: 3.5)
    }
}
