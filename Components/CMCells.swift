//
//  CMCells.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/19/23.
//

import SwiftUI

struct CMCells: View {
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
            
            Divider()
            
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text("Channel")
                        .fontWeight(.semibold)
                    
                    Text("16m ago")
                }
                .font(.footnote)
                
                Spacer()
                
                Text("9")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 32)
                    .foregroundColor(.red)
                    .overlay {
                        Circle()
                            .stroke(Color("LTBL"), lineWidth: 1)
                    }
            }
            
        }
        .padding(.horizontal,43)
    }
}

struct CMCells_Previews: PreviewProvider {
    static var previews: some View {
        CMCells()
    }
}

