//
//  PfpPosts.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/18/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct PfpPosts: View {
    
    @ObservedObject var postData = PostData()
    @State private var userPosts: [PostData.Post] = []
    var userid: String
    
    init(userid: String? = Auth.auth().currentUser?.uid) {
        self.userid = userid ?? "defaultUserId" // A default value or another appropriate handling
    }
    
    var body: some View {
        NavigationStack{
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
}
struct PfpPosts_Previews: PreviewProvider {
    static var previews: some View {
        PfpPosts()
    }
}
