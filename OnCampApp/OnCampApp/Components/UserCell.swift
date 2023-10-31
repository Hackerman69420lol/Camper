//
//  UserCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//


import SwiftUI

struct UserCell: View {
    let user: User
    var body: some View {
        VStack {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.username)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(user.status)
                        .font(.system(size:15))
                }
                .font(.footnote)
                .foregroundColor(Color("LTBL"))
                
                Spacer()
                
            }
            .padding(.horizontal)
           
        }
        .padding(.top)
    }
}


