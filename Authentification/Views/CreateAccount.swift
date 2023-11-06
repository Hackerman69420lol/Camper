//
//  CreateAccount.swift
//  OnCampRelease
//
//  Created by Michael Washington on 9/30/23.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseStorage
import FirebaseFirestore

struct CreateAccount: View {
    
    var uid: String
    
    @ObservedObject var userData = UserData()
    
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    @State private var profileImage: UIImage?
    @State private var isActive: Bool = false
    @State private var isShowingImagePicker = false
    @State private var showSelectInterestPage = false
    @State private var isAccountCreated : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Title and profile image
                Text("Create Your Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 35)
                
                if profileImage != nil {
                    Image(uiImage: profileImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 5)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 5)
                }
                
                // Button to upload profile picture
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    Text("Upload Profile Picture")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$profileImage, sourceType: .photoLibrary)
                }
                
                // Form for profile information
                Form {
                    Section(header: Text("Profile Information")) {
                        TextField("Username (Required)", text: $userData.username)
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Biography (Max 150 characters)", text: $userData.bio)
                            .frame(height: 100)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Username (Required)", text: $userData.status)
                            .font(.headline)
                            .foregroundColor(.black)
                        Picker("School", selection: $userData.school) {
                            ForEach(userData.colleges, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                
                // Create account button
                
                Button(action: {
                    createAccount(bio: userData.bio, username: userData.username, school: userData.school, status: userData.status, followerCount: 0, followingCount: 0, isVendor: false)
                    isAccountCreated = true
                }) {
                    Text("Continue")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                .padding(.horizontal, 16)
                .padding(.bottom, 50)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
                }
            }
            .padding() // Add padding to the VStack content
            .navigationBarHidden(true) // Hide the navigation bar
        }
        .navigationDestination(isPresented: $isAccountCreated) {
            Interests(uid: self.uid)
        }
        .accentColor(.blue)
        .padding(.bottom, 5)
        
    }
    
    private func loadImage() {
        guard let _ = profileImage else {
            self.alertMessage = "Please select a profile picture"
            self.showingAlert = true
            return
        }
    }
    
    
    @MainActor
    func createAccount(bio: String, username: String, school: String, status: String, followerCount: Int, followingCount: Int, isVendor: Bool) {
        // Get the user's UID
        let uid = Auth.auth().currentUser!.uid
        
        // Create a reference to the user's document in the "Users" collection
        let userRef = USER_COLLECTION.document(uid)
        let usernameRef = Firestore.firestore().collection("Usernames").document(username)
        
        // Create a dictionary of the user's data
        let userData = [
            "bio": bio,
            "username": username,
            "school": school,
            "status": status,
            "isVendor": isVendor,
            "followingCount": followingCount,
            "followerCount": followerCount,
            
        ] as [String: Any]
        
        // Set the user's data in the database
        userRef.setData(userData) { error in
            if let error = error {
                // Handle the error
                print("Error setting user data: \(error.localizedDescription)")
            } else {
                // The user's data has been successfully saved
                print("User data saved successfully")
            }
        }
        usernameRef.setData(["uid": self.uid]) { error in
            if let error = error {
                // Handle the error
                print("Error setting document: \(error.localizedDescription)")
            } else {
                // The user's data has been successfully saved
                print("User data saved successfully")
                isAccountCreated = true
            }
        }
    }
    
    
}

struct CreateAccount_Previews: PreviewProvider {
    var uid: String
    static var previews: some View {
        CreateAccount(uid: "MN9JWn0N3IYlkDPVpjunmCZkwGz2" )
    }
}

