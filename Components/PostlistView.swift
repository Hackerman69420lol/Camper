//
//  PostlistView.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/14/23.
//

import SwiftUI

struct PostListView: View {
    @EnvironmentObject var postData : PostData
  @State private var posts = [PostData.Post]()

  var body: some View {
    ScrollView {
        VStack(spacing: 0) {
            ForEach(postData.publicposts, id: \.postId) { post in
                PostCell(postText: post.content, likeCount: post.likeCount, repostCount: post.repostCount, commentCount: post.commentCount, posterUid: post.postedBy, username: post.username, postedAt: post.postedAt, Id: post.postId)
            }
        }
    }

  }
}



struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
      PostListView()
          .environmentObject(PostData())
  }
}
