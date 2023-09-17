//
//  UserCell.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/13/23.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
           
            CircularProfilePictureView()
            
            VStack(alignment: .leading) {
                Text("AUC Lovebirds")
                    .fontWeight(.semibold)
                
                Text("Geeked")
            }
            .font(.footnote)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("LTBL"), lineWidth: 1)
                }
        }
        .padding(.horizontal)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
