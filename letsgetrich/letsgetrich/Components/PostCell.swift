//
//  PostCell.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/13/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct PostCell: View {

    var body: some View {
       
        VStack {
            HStack(alignment: .top, spacing: 12) {
                
                CircularProfilePictureView()
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Auc Love Birds")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                        
                        Text("10m")
                            .font(.caption)
                            .foregroundColor(Color("LTBL"))
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color("LTBL"))
                        }
                    }
                    
                    Text("We love OnCamp")
                        .font(.footnote)
                        .multilineTextAlignment(.leading )
                    
                    HStack(spacing: 16) {
                        Button {
                            
                        }   label: {
                            Image(systemName: "heart")
                        }
                        Button {
                            
                        }   label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                            
                        }   label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button {
                            
                        }   label: {
                            Image(systemName: "paperplane")
                        }
                        
                    }
                    .foregroundColor(Color("LTBL"))
                    .padding(.vertical, 8)
                }
            }
            
            Divider()
        }
        .padding()
    }
}


struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}

