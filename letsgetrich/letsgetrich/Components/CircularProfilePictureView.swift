//
//  CircularProfilePictureV.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/13/23.
//

import SwiftUI

struct CircularProfilePictureView: View {
    var body: some View {
        Image("spelhouse")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

struct CircularProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfilePictureView()
    }
}
