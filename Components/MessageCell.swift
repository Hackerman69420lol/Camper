//
//  MessageCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct MessageCell: View {
    var body: some View {
        VStack {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("BigDaddyMike")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("A real Nigga sent a Message")
                        .font(.system(size: 15))
                }.foregroundColor(Color("LTBL"))
                
                Spacer()
                
            }
            .padding(.horizontal)
            
            Divider()
        }
        .padding(.top)
    }
}

struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell()
    }
}
