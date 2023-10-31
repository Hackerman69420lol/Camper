//
//  PostlistView.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/14/23.
//

import SwiftUI

struct PostListView: View {
  @ObservedObject var postData = PostData()
  @State private var posts = [PostData.Post]()

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(posts, id: \.postId) { post in
            PostCell(postText: post.postText, likeCount: post.likeCount, repostCount: post.repostCount, commentCount: post.commentCount, posterUid: post.posterUid,username: post.username, postedAt: post.postedAt, postId: post.postId)
        }
      }
    }
    .onAppear {
      Task {
        do {
          posts = try await postData.fetchPostIDs()
        } catch {
          print("Error fetching posts: \(error)")
        }
      }
    }
  }
}



struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
