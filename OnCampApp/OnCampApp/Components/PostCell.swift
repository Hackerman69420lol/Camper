//
//  PostsCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore




struct PostCell: View {
    @ObservedObject var postData = PostData()
    @State private var post = [PostData.Post]()

    var postText: String
    var likeCount: Int
    var repostCount: Int
    var commentCount: Int
    var posterUid: String
    var username: String
    var postedAt: Date
    var postId: String = ""
    var userId = Auth.auth().currentUser!.uid
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(username)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                        
                        Text("Posted at: \(postedAt, style: .relative) ago") // Format the postedAt timestamp
                            .font(.caption)
                            .foregroundColor(Color("LTBL"))
                        Button {
                            // Handle button action here
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color("LTBL"))
                        }
                    }
                    
                    Text(postText)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16) {
                        Button {
                            // Handle button action here
                           
                            postData.likePost(postID: postId, userID: userId)
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        Button {
                            // Handle button action here
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                            postData.repostPost(postID: postId, userID: userId)
                            // Handle button action here
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button {
                            // Handle button action here
                        } label: {
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
        PostCell(
            postText: "This is a sample post text",
            likeCount: 42,
            repostCount: 18,
            commentCount: 7,
            posterUid: "sampleuser123",
            username: "x",
            postedAt: Date(),
            postId: "Q5902F7R5zmKyVK08BYq",
            userId: "defaultUserId" // Provide a default value for userId in the preview
        )
    }
}

