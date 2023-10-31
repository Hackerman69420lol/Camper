//
//  PostData.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/13/23.
//

import Foundation
import Firebase
import Combine
import FirebaseFirestore


class PostData: ObservableObject {
    @Published var hasFetchedData = false
    struct Post {
        var postId: String
        var postText: String
        var posterUid: String
        var postedAt: Date
        var likeCount: Int
        var repostCount: Int
        var commentCount: Int
        var username: String
        
    }
    
    @Published var postId: String = ""
    @Published var postText: String = ""
    @Published var posterUid: String = ""
    @Published var postedAt: Date = Date()
    @Published var likeCount: Int = 0
    @Published var repostCount: Int = 0
    @Published var commentCount: Int = 0
    @Published var username: String = ""
 

    enum PostOption: String, CaseIterable, Identifiable {
        case publicPost = "Public"
        case followersPost = "Followers"
        case favoritesPost = "Favorites"

        var id: String { self.rawValue }
    }
    enum MyError: Error {
        case fetchPostDataFailed
        case otherError
    }


    func fetchPostIDs() async -> [PostData.Post] {
        let db = Firestore.firestore()
        let postsRef = db.collection("Posts")

        var fetchedPosts: [PostData.Post] = []

        do {
            let querySnapshot = try await postsRef.limit(to: 15).getDocuments()

            for document in querySnapshot.documents {
                let postID = document.documentID
                print("Fetched post ID: \(postID)")

                // Use Task to asynchronously fetch post data
                do {
                    let post = try await fetchPostData(postID: postID)
                    fetchedPosts.append(post)
                } catch MyError.fetchPostDataFailed {
                    print("Error fetching post data for post ID: \(postID)")
                } catch {
                    print("Other error: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Error fetching post IDs: \(error.localizedDescription)")
        }

        return fetchedPosts
    }

    func fetchPostData(postID: String) async throws -> PostData.Post {
        let db = Firestore.firestore()
        let docRef = db.collection("Posts").document(postID)
        
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                // Extract and handle the post data as needed
                let postText = document.data()?["content"] as? String ?? ""
                let username = document.data()?["username"] as? String ?? ""
                let posterUid = document.data()?["postedBy"] as? String ?? ""
                let postedAtTimestamp = document.data()?["postedAt"] as? Timestamp
                let postedAt = postedAtTimestamp?.dateValue() ?? Date()
                let likeCount = document.data()?["likeCount"] as? Int ?? 0
                let repostCount = document.data()?["repostCount"] as? Int ?? 0
                let commentCount = document.data()?["commentCount"] as? Int ?? 0
                
                // Now you have the post data, you can do what you need with it

                return PostData.Post(postId: postID, postText: postText, posterUid: posterUid, postedAt: postedAt, likeCount: likeCount, repostCount: repostCount, commentCount: commentCount, username: username)
            } else {
                print("Document does not exist")
                throw MyError.fetchPostDataFailed
            }
        } catch {
            print("Error fetching document: \(error)")
            throw MyError.fetchPostDataFailed
        }
    }

    func fetchUserPostsIds(userId: String) async throws -> [String] {
        let db = Firestore.firestore()
        let userPostsRef = db.collection("Users").document(userId).collection("Posts")

        do {
            let querySnapshot = try await userPostsRef.getDocuments()

            let postIDs = querySnapshot.documents.map { $0.documentID }
            return postIDs
            
           
        } catch {
            print("Error fetching user-specific post IDs: \(error.localizedDescription)")

            throw error // Re-throw the error for better debugging
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
                        print("Error updating likeCount: \(error.localizedDescription)")
                    } else {
                        // Add the user's ID to the post's likes subcollection
                        postRef.collection("likes").document(userID).setData([:]) { error in
                            if let error = error {
                                print("Error adding user to likes subcollection: \(error.localizedDescription)")
                            } else {
                                // Add the liked post's ID to the user's likes collection
                                userRef.collection("likes").document(postID).setData([:]) { error in
                                    if let error = error {
                                        print("Error adding liked post to user's likes collection: \(error.localizedDescription)")
                                    } else {
                                        print("Post liked successfully!")
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                print("Post not found")
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
                        print("Error updating repostCount: \(error.localizedDescription)")
                    } else {
                        // Add the user's ID to the post's reposts subcollection
                        postRef.collection("reposts").document(userID).setData([:]) { error in
                            if let error = error {
                                print("Error adding user to reposts subcollection: \(error.localizedDescription)")
                            } else {
                                // Add the reposted post's ID to the user's reposts collection
                                userRef.collection("reposts").document(postID).setData([:]) { error in
                                    if let error = error {
                                        print("Error adding reposted post to user's reposts collection: \(error.localizedDescription)")
                                    } else {
                                        print("Post reposted successfully!")
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                print("Post not found")
            }
        }
    }

    // Call the function to fetch a specific user's posts

    // Add more @Published properties as needed for other post data
    struct Comment {
        var commenterUid: String
        var text: String
        var timeSent: Date
        var commentReposts: Int
        var commentLikes: Int
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
                print("Error adding comment: \(error)")
            } else {
                print("Comment added successfully")
            }
        }
    }

}
