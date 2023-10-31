//
//  User Post View.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/14/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct UserPostsView: View {
    @ObservedObject var postData = PostData()
    @State private var userPosts: [PostData.Post] = []
    var userid = Auth.auth().currentUser!.uid

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(userPosts, id: \.postId) { post in
                    PostCell(postText: post.postText, likeCount: post.likeCount, repostCount: post.repostCount, commentCount: post.commentCount, posterUid: post.posterUid, username: post.username, postedAt: post.postedAt, postId: post.postId)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await postData.fetchUserPostsIds(userId: userid)
                } catch {
                    // Handle the error here
                    print("Error: \(error)")
                }
            }
        }



        }

    }

struct UserPostsViewPreviews: PreviewProvider {
    static var previews: some View {
        UserPostsView(userid: "defaultUserId")
    }
}
