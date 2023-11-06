//
//  DetailedComment.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI

struct DetailedCommentCell: View {
    var body: some View {
        VStack {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 18.0)
                
                Text("Other NIgga")
                
                Spacer()
                
                Text("2m ago")
                    .padding(.trailing, 18.0)
                
            }
            .padding(.top, 18.0)
            
            HStack{
                Text("Bro for surely didnt lie.")
                    .padding(.leading, 18.0)
                
                Spacer()
                
                Text("1900")
                Image(systemName: "heart")
                Image(systemName: "paperplane")
                    .padding(.trailing, 18.0)
            }
            .padding(.top, 5.0)
            
            HStack {
                Text("View Replies (3)...")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 18.0)
                    .padding(.top, 3.0)
                Spacer()
            }
            
            
            Divider()
            
            Spacer()
        }
    }
}

struct DetailedCommentCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailedCommentCell()
    }
}
