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
            Text("Fetch user posts here")
        }
       


        }

    }

struct UserPostsViewPreviews: PreviewProvider {
    static var previews: some View {
        UserPostsView(userid: "defaultUserId")
    }
}
