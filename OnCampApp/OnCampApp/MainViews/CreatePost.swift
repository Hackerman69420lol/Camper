//
//  CreatePost.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/16/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore



struct CreatePost: View {
    
    @ObservedObject var postData = PostData()
    @State private var selectedOption = PostData.PostOption.publicPost
    @State private var showDropdown = false
    @State private var postText = "" // Text entered in the text box
    @FocusState private var isCreatingPost: Bool
    
    // Function to count the number of characters in the text
    private var characterCount: Int {
        return postText.count
    }
    
    var body: some View {
        ZStack {
            // Background color for the entire view
            Color.white
            
            // Rectangle with grey outline in the middle
           
            
            // Red Trash Can Icon in the top-left corner
            Image(systemName: "trash.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .offset(x: -170, y: 170) // Adjustable x and y positions for the trash can
            
            // Profile Picture in the top-left corner of the rectangle
            VStack {
                CircularProfilePictureView() // Add your profile picture view here
            }
            .offset(x: -175, y: -265) // Adjust the profile picture position
            
            // Dropdown Selector (Custom Dropdown) in a rounded rectangle
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue) // Change the color to blue
                .foregroundColor(.white)
                .frame(width: 150, height: 30)
                .overlay(
                    Button(action: {
                        showDropdown.toggle()
                    }, label: {
                        Text(selectedOption.rawValue)
                            .foregroundColor(.white)
                    })
                )
                .offset(x: -50, y: -270) // Move the dropdown to be on the same y-axis as the profile picture
                .padding(.leading, 20) // Adjust the left padding to move the entire VStack to the right
            
            // Text box inside the rectangle
            ZStack(alignment: .topLeading) {
                // Gray background for the text editor
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                
                // Actual text box to enter text
                TextEditor(text: $postText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .focused($isCreatingPost)
                
                // Placeholder text when no text is entered
                if postText.isEmpty {
                    Text("Share what's on your mind...")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 12)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done"){
                        isCreatingPost = false
                    }
                }
            }
            .frame(width: 370, height: 300) // Adjust the size of the text box
            .cornerRadius(8)
            .offset(x: 0, y: -80) // Adjustable x and y positions for the text box
            
            // Blue Send Button
            Button(action: {
                // Action when the send button is tapped
                createPost()
            }) {
                Text("Send")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .offset(x: 140, y: 170) // Adjustable x and y positions for the send button
            
            // Image buttons for uploading photo, using GIF, adding poll, and using emojis
            ZStack(alignment: .topLeading) {
                HStack {
                    // Placeholder image buttons for other actions
                }
            }
            
            // Character counter
            HStack {
                Spacer()
                Text("Character Count: \(characterCount)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .offset(x: -40, y: -130)
            }
            .padding(.top, 350) // Adjustable position for the character counter
            
            // Custom Dropdown View
            VStack(spacing: 8) {
                ForEach(PostData.PostOption.allCases) { option in
                    Button(action: {
                        withAnimation(.easeIn){
                            selectedOption = option
                            showDropdown.toggle()
                        }
                    }) {
                        Text(option.rawValue)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            .background(Color.blue) // Change the color to blue
            .cornerRadius(8)
            .offset(x: 0, y: -180) // Move the dropdown below the text box
            .opacity(showDropdown ? 1 : 0) // Show the dropdown when showDropdown is true
        }
    }
    func createPost() {
        let db = Firestore.firestore()
        let postRef = db.collection("Posts").document()
        let posterUid = Auth.auth().currentUser!.uid
        let postId = postRef.documentID

        // Fetch the user's username from the "Users" collection
        let usersRef = db.collection("Users").document(posterUid)
        usersRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let username = document.data()?["username"] as? String {
                    // Create post data for the "Posts" collection
                    let postData: [String: Any] = [
                        "content": postText,
                        "postedAt": Date(),
                        "postedBy": posterUid,
                        "security": selectedOption.rawValue,
                        "likeCount": 0,
                        "commentCount": 0,
                        "repostCount": 0,
                        "postId": postId,
                        "username": username // Add the username
                        // Add other post data here
                    ]

                    // Set the post data in the "Posts" collection
                    postRef.setData(postData) { error in
                        if let error = error {
                            // Handle the error
                            print("Error setting post data: \(error.localizedDescription)")
                        } else {
                         
                            // The post data has been successfully saved
                            print("Post data saved successfully")
                            print(postId)
                            
                            // Add a reference to the post in the user's posts subcollection
                            let userPostsRef = db.collection("Users").document(posterUid).collection("Posts")
                            userPostsRef.document(postId).setData(["postRef": postRef])
                        }
                    }
                }
            } else {
                // Handle the case where the user's document does not exist or an error occurred
                print("Error fetching user data: \(error?.localizedDescription ?? "User document does not exist")")
            }
        }
    }


}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost()
    }
}
