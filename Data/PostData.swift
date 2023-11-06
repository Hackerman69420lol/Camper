//
//  PostData.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/13/23.
//


import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift



@MainActor
class PostData: ObservableObject {
    @Published var hasFetchedData = false
    @Published var likedPosts: [Post] = []
    @Published var userPosts: [Post] = []
    @Published var repostedPosts: [Post] = []
    @Published var posts: [Post] = []
    @Published var publicposts: [Post] = []


    struct Post: Codable, Identifiable {
        @DocumentID var id: String?
        var commentCount: Int
        var content: String
        var likeCount: Int
        var postId: String
        var postedAt: Date
        var postedBy: String
        var repostCount: Int
        var security: String
        var username: String

        enum CodingKeys: String, CodingKey {
            case id
            case commentCount
            case content
            case likeCount
            case postId
            case postedAt
            case postedBy
            case repostCount
            case security
            case username
        }

        
    }

    
    enum PostOption: String, CaseIterable, Identifiable {
           case publicPost = "Public"
           case campus = "Campus"
           case following = "Following"
           case favorites = "Favorites"

           // Conformance to Identifiable
           var id: Self { self }
       }

  
    
    func fetchLikedPosts() async throws {
        let userId = loggedInUser
        let db = Firestore.firestore()
        let likesSnapshot = try await db.collection("Users").document(userId)
          .collection("likes").getDocuments()

        // Extract postIds from likesSnapshot, assuming the documents in the "likes" collection
        // only contain a reference to the postIds
        let postIds = likesSnapshot.documents.map { $0.documentID }
        
        // Create a query to fetch posts with the IDs from postIds
        let postsQuery = db.collection("Posts").whereField(FieldPath.documentID(), in: postIds)
        let postsSnapshot = try await postsQuery.getDocuments()
        
        // Use the fetchPosts function to get the actual Post objects
        let fetchedPosts = try await fetchPosts(from: postsSnapshot)
        
        // Now you can update your UI or state with the fetched posts on the main thread
        DispatchQueue.main.async {
            self.likedPosts = fetchedPosts
            print(fetchedPosts)
        }
    }

    func fetchPublicPosts() async throws {
        do {
            let db = Firestore.firestore()
            let querySnapshot = try await db.collection("Posts")
                .whereField("security", isEqualTo: "Public")
                .order(by: "postedAt", descending: true)
                .limit(to: 25)
                .getDocuments()

            // Fetch the posts from the snapshot using the private fetchPosts function.
            let fetchedPosts = try await fetchPosts(from: querySnapshot)
            
            // Since we're in an async context and may be on a background thread,
            // we'll use @MainActor to switch to the main thread to update the UI.
            await MainActor.run {
                self.publicposts = fetchedPosts
            }
            
            print("DEBUG:: Fetched Public Posts: \(fetchedPosts.map { $0.content })")
            
        } catch {
            print("Error fetching public posts: \(error)")
        }
    }

    
    func fetchRepostedPosts() async throws {
        let userId = loggedInUser
        let db = Firestore.firestore()
        let repostsSnapshot = try await db.collection("Users").document(userId)
          .collection("reposts").getDocuments()

        // Extract postIds from likesSnapshot, assuming the documents in the "likes" collection
        // only contain a reference to the postIds
        let postIds = repostsSnapshot.documents.map { $0.documentID }
        
        // Create a query to fetch posts with the IDs from postIds
        let postsQuery = db.collection("Posts").whereField(FieldPath.documentID(), in: postIds)
        let postsSnapshot = try await postsQuery.getDocuments()
        
        // Use the fetchPosts function to get the actual Post objects
        let fetchedPosts = try await fetchPosts(from: postsSnapshot)
        
        // Now you can update your UI or state with the fetched posts on the main thread
        DispatchQueue.main.async {
            self.repostedPosts = fetchedPosts
            print(fetchedPosts)
        }
    }

    
    private func fetchPosts(from snapshot: QuerySnapshot) async throws -> [Post] {
        let db = Firestore.firestore()
        var posts: [Post] = []
        
        for document in snapshot.documents {
            let postId = document.documentID
            let postSnapshot = try await db.collection("Posts").document(postId).getDocument()
            if var post = try? postSnapshot.data(as: Post.self) {
                post.id = postId  // Assuming the Post model has an 'id' property to hold the document ID
                posts.append(post)
                // Now print the post data to verify
                print("DEBUG:: Post ID: \(postId), Content: \(post.content)")
            }
        }
        
        // If the posts array is empty after the loop, it means no posts were fetched or appended.
        if posts.isEmpty {
            print("DEBUG:: No posts were fetched or appended.")
        }
        
        return posts
    }

    func fetchPostsForLoggedInUser() async throws {
        let db = Firestore.firestore()
        let userId = loggedInUser
        let querySnapshot = try await db.collection("Posts")
            .whereField("posterUid", isEqualTo: userId).getDocuments()
        
        let posts = querySnapshot.documents.compactMap { document -> Post? in
            try? document.data(as: Post.self)
        }

        // Update your published property with the fetched posts
        // Ensure UI updates are on the main thread
        DispatchQueue.main.async {
            self.userPosts = posts
             ("Debug:: \(self.userPosts)")
            self.hasFetchedData = true // If you have a flag like this
        }
    }

    
        
    func likePost(postID: String, userID: String) {
        
        let db = Firestore.firestore()
        let postRef = db.collection("Posts").document(postID)
        let userRef = db.collection("Users").document(userID)
        
        // Fetch the post document
        postRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Get the current likeCount
                let currentLikeCount = document.data()?["likeCount"] as? Int ?? 0
                
                // Update the likeCount
                let newLikeCount = currentLikeCount + 1
                postRef.updateData(["likeCount": newLikeCount]) { error in
                    if let error = error {
                        ("Error updating likeCount: \(error.localizedDescription)")
                    } else {
                        // Add the user's ID to the post's likes subcollection
                        postRef.collection("likes").document(userID).setData([:]) { error in
                            if let error = error {
                                ("Error adding user to likes subcollection: \(error.localizedDescription)")
                            } else {
                                // Add the liked post's ID to the user's likes collection
                                userRef.collection("likes").document(postID).setData([:]) { error in
                                    if let error = error {
                                        ("Error adding liked post to user's likes collection: \(error.localizedDescription)")
                                    } else {
                                        ("Post liked successfully!")
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                ("Post not found")
            }
        }
    }
    
    func repostPost(postID: String, userID: String) {
        let db = Firestore.firestore()
        let postRef = db.collection("Posts").document(postID)
        let userRef = db.collection("Users").document(userID)
        
        // Fetch the post document
        postRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Get the current repostCount
                let currentRepostCount = document.data()?["repostCount"] as? Int ?? 0
                
                // Update the repostCount
                let newRepostCount = currentRepostCount + 1
                postRef.updateData(["repostCount": newRepostCount]) { error in
                    if let error = error {
                        ("Error updating repostCount: \(error.localizedDescription)")
                    } else {
                        // Add the user's ID to the post's reposts subcollection
                        postRef.collection("reposts").document(userID).setData([:]) { error in
                            if let error = error {
                                ("Error adding user to reposts subcollection: \(error.localizedDescription)")
                            } else {
                                // Add the reposted post's ID to the user's reposts collection
                                userRef.collection("reposts").document(postID).setData([:]) { error in
                                    if let error = error {
                                        ("Error adding reposted post to user's reposts collection: \(error.localizedDescription)")
                                    } else {
                                        ("Post reposted successfully!")
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                ("Post not found")
            }
        }
    }
    
    
    
    
    func createComment(postID: String, commenterUid: String, commentText: String) {
        let db = Firestore.firestore()
        
        // Define a dictionary to represent the comment data
        let commentData: [String: Any] = [
            "commenterUid": commenterUid, // Use the current user's UID
            "text": commentText, // Use the commentText parameter
            "timeSent": Timestamp(date: Date()), // Use the current date and time
            "commentReposts": 0, // You can set initial values here
            "commentLikes": 0
        ]
        
        // Reference to the post document
        let postRef = db.collection("Posts").document(postID)
        
        // Add the comment data to the comments subcollection of the post
        postRef.collection("comments").addDocument(data: commentData) { error in
            if let error = error {
                ("Error adding comment: \(error)")
            } else {
                ("Comment added successfully")
            }
        }
    }
    
}
