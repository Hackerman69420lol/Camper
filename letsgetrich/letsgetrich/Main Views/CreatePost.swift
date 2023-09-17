//
//  CreatePost.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/16/23.
//

import SwiftUI

enum PostOption: String, CaseIterable, Identifiable {
    case publicPost = "Public"
    case followersPost = "Followers"
    case favoritesPost = "Favorites"

    var id: String { self.rawValue }
}

struct CreatePost: View {
    @State private var selectedOption = PostOption.publicPost
    @State private var showDropdown = false
    @State private var postText = "" // Text entered in the text box

    // Function to count the number of characters in the text
    private var characterCount: Int {
        return postText.count
    }

    var body: some View {
        ZStack {
            // Background color for the entire view
            Color.white

            // Rectangle with grey outline in the middle
            Rectangle()
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 400, height: 500) // Adjust the width and height as needed
                .offset(y: -50)

            // Red Trash Can Icon in the top-left corner
            Image(systemName: "trash.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .offset(x: -170, y: 100) // Adjustable x and y positions for the trash can

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

                // Placeholder text when no text is entered
                if postText.isEmpty {
                    Text("Share what's on your mind...")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 12)
                }
            }
            .frame(width: 370, height: 300) // Adjust the size of the text box
            .cornerRadius(8)
            .offset(x: 0, y: -80) // Adjustable x and y positions for the text box

            // Blue Send Button
            Button(action: {
                // Action when the send button is tapped
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
                ForEach(PostOption.allCases) { option in
                    Button(action: {
                        selectedOption = option
                        showDropdown.toggle()
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
            .animation(.default)
        }
    }
}
    

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost()
    }
}
