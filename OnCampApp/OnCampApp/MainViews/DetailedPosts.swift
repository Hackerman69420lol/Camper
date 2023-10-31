//
//  DetailedPosts.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase

struct DetailedPosts: View {
    @ObservedObject var postData = PostData()
    @State private var post = [PostData.Post]()
    var postId: String = "4ljhkGhegmkmeHmLMmL2"
    var userId = Auth.auth().currentUser!.uid
    var commenterUid = Auth.auth().currentUser!.uid
    @State private var Commenttext: String = ""
    
    
    var body: some View {
        VStack{
            DetailedPostCell(postText: "This is a sample post text",
                             likeCount: 42,
                             repostCount: 18,
                             commentCount: 7,
                             posterUid: "sampleuser123",
                             username: "x",
                             postedAt: Date(),
                             postId: "4ljhkGhegmkmeHmLMmL2",
                             userId: "defaultUserId")
            
            DetailedCommentCell()
            
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
            HStack {
                TextField("Reply...", text: $Commenttext)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.body)
                    .frame(minHeight: 30)
                
                Button(action: {
                    postData.createComment(postID: postId, commenterUid: commenterUid, commentText: Commenttext)
                    print(Commenttext) // Use Commenttext instead of text
                }) {
                    Text("Send")
                        .bold()
                        .foregroundColor(Color("LTBL"))
                }
            }
            .padding(.bottom,8)
            .padding(.horizontal)
        }
    }
}


struct DetailedPosts_Previews: PreviewProvider {
    static var previews: some View {
        DetailedPosts()
    }
}
