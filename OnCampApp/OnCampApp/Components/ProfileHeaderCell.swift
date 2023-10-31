//
//  ProfileHeaderCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/27/23.
//

import SwiftUI

struct ProfileHeaderCell: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("AUC Lovebirds")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("@OnCampOfficial")
                            .font(.subheadline)
                    }
                    
                    Text("YRN")
                        .font(.footnote)
                    
                    Text("5000 followers")
                        .font(.caption)
                        .foregroundColor(Color("LTBL"))
                }
                
                Spacer()
                
                CircularProfilePictureView()
                    .frame(width: 64, height: 64)
            }
            
            Button {
                
            } label: {
                Text("Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("LTBLALT"))
                    .frame(width: 352, height: 32)
                    .background(Color("LTBL"))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 6.0)
    }
}
    
    struct ProfileHeaderCell_Previews: PreviewProvider {
        static var previews: some View {
            ProfileHeaderCell()
        }
    }
