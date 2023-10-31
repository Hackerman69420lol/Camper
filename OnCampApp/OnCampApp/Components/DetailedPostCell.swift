//
//  DetailedPostCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
struct DetailedPostCell: View {
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
            
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                
                
                Text("OnCampCreator")
                
                Spacer()
                
                Text("15m ago")
                
            }
            .padding(.top, 18.0)
            
            HStack {
                Text("@bigdaddymike")
                
                    .foregroundColor(.blue)
                
                Spacer()
            }
            
            Text("This is some funny shit right here in this tweet i promise you.")
                .multilineTextAlignment(.leading)
                .padding(.top, 30.0)
            
            
            
            HStack() {
                Button {
                    // Handle button action here
                    postData.likePost(postID: postId, userID: userId)
                } label: {
                    Image(systemName: "heart")
                }
                
                Button {
                    postData.repostPost(postID: postId, userID: userId)
                } label: {
                    Image(systemName: "arrow.rectanglepath")
                }
                Button {
                    // Handle button action here
                } label: {
                    Image(systemName: "paperplane")
                }
                Spacer()
                
                Text("\(likeCount) likes   \(repostCount) Reposts   \(commentCount) Comments")
                    .font(.footnote)

                   
            }
            .padding([.top, .leading], 18.0)
            .foregroundColor(Color("LTBL"))
            
            Divider()
        }
    }
}

struct DetailedPostCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailedPostCell(
                        postText: "This is a sample post text",
                          likeCount: 42,
                          repostCount: 18,
                          commentCount: 7,
                          posterUid: "sampleuser123",
                          username: "x",
                          postedAt: Date(),
                          postId: "4ljhkGhegmkmeHmLMmL2",
                          userId: "defaultUserId")
    }
}
