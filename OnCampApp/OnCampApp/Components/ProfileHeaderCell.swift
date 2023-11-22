//
//  ProfileHeaderCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/27/23.
//

import SwiftUI

struct ProfileHeaderCell: View {
    var body: some View {
        NavigationStack {
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
                        .frame(width: 80, height: 80)
                }
                HStack{
                    NavigationLink(destination: editProfileView()) {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("LTBLALT"))
                            .frame(width: 352, height: 32)
                            .background(Color("LTBL"))
                            .cornerRadius(8)
                        
                    }
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                        
                    }
                }
            }
            .padding(.horizontal, 6.0)
        }
    }
}

struct ProfileHeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderCell()
    }
}
