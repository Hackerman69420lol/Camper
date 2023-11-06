//
//  ProfileHeaderCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/27/23.
//

import SwiftUI

struct ProfileHeaderCell: View {
    var user: UserData.User
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 64, height: 64)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(user.username)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user.school)
                        .font(.subheadline)
                    
                    Text(user.bio)
                        .font(.footnote)
                    
                    Text(user.status)
                        .font(.footnote)
                    
                    HStack {
                        Text("\(user.followerCount) followers")
                            .font(.caption)
                        Text("\(user.followingCount) following")
                            .font(.caption)
                    }
                    .foregroundColor(Color("LTBL"))
                }
                
                Spacer()
            }
            .padding(.top, 18.0)
            
            Button {
                // Handle follow action
            } label: {
                Text("Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("LTBLALT"))
                    .frame(width: 352, height: 32)
                    .background(Color("LTBL"))
                    .cornerRadius(8)
            }
            .padding(.bottom, 18.0)
        }
    }
}

struct ProfileHeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderCell(user: UserData.User(
           
            username: "JaneDoe123",
            bio: "SwiftUI enthusiast. Love to code and design apps.",
            status: "Currently Online",
            school: "University of SwiftUI",
            interests: [],
            profilePictureURL: "",
            followerCount: 120,
            followingCount: 75,
            postCount: 10,
            isVendor: false
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
