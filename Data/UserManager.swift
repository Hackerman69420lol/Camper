//
//  UserManager.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import Foundation
import FirebaseAuth
import Firebase

extension OnCampAppApp {
    struct User {
        var uid: String
        var username: String
        var bio: String
        var status: String
        var school: String
        var interests: [String]
        var profilePictureURL: String
        var followerCount: Int
        var favorites: Int
        var followingCount: Int
        var postCount: Int
        var isVendor: Bool

        // Initializer to create an OnCampApp.User from Firebase.User and additional data
        init(firebaseUser: Firebase.User, username: String = "", bio: String = "", status: String = "", school: String = "", interests: [String] = [], profilePictureURL: String = "", followerCount: Int = 0, favorites: Int = 0, followingCount: Int = 0, postCount: Int = 0, isVendor: Bool = false) {
            self.uid = firebaseUser.uid
            self.username = username
            self.bio = bio
            self.status = status
            self.school = school
            self.interests = interests
            self.profilePictureURL = profilePictureURL
            self.followerCount = followerCount
            self.favorites = favorites
            self.followingCount = followingCount
            self.postCount = postCount
            self.isVendor = isVendor
        }
    }
}

// Assume that OnCampApp is a namespace or a struct you've defined elsewhere in your code to encapsulate your app's components.
private func convertToAppUser(firebaseUser: Firebase.User) -> OnCampAppApp.User {
    // Since we don't have the additional user info right when signing up,
    // we return an OnCampApp.User with the default values for the extra fields.
    // You will need to update these fields later as appropriate for your app.
    return OnCampAppApp.User(
        firebaseUser: firebaseUser
    )
}
