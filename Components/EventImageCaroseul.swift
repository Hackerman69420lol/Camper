//
//  EventImageCaroseul.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/30/23.
//

import SwiftUI

struct EventImageCarousel: View {
    var images = [
        "Events1",
        "Events2",
        "Events3",
    ]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
        
        .tabViewStyle(.page)
    }
}

struct EventImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        EventImageCarousel()
    }
}
