//
//  UserData.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/9/23.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class UserData: ObservableObject {
    @Published var statuses: [String] = []
       @Published var colleges: [String] = []
    static let shared = UserData()
    
    // Firebase authentication state
    @Published var isLoggedIn: Bool = false
    
    // Firebase user object
    @Published var currentUser: User?
    
    init() {
        self.colleges = [
            "University of Georgia (UGA)",
            "Georgia State University",
            "Georgia Institute of Technology (Georgia Tech)",
            "Morehouse College",
            "Spelman College",
            "Emory University",
            "Georgia Southern University",
            "Kennesaw State University",
            "Mercer University",
            "Clark Atlanta University",
            "Agnes Scott College",
            "Savannah State University",
            "Georgia College & State University",
            "Columbus State University",
            "Georgia Southern University",
            "Valdosta State University",
            "Augusta University",
            "University of West Georgia",
            "Georgia Southwestern State University",
            "Georgia Gwinnett College",
            "Oglethorpe University",
            "Berry College",
            "Piedmont College",
            "Reinhardt University",
            "Wesleyan College",
            "University of North Georgia",
            "Albany State University",
            "Fort Valley State University",
            "Middle Georgia State University",
            "Clayton State University"
        ] // List of colleges in Georgia
        self.statuses = [
            "Bored 😑",
            "Chilling 😎",
            "Drunk 🍻",
            "Excited 🤩",
            "Geeked 🤓",
            "Hanging Out 🤙",
            "Napping 😴",
            "Netflix and Chill 🍿",
            "Partying 🎉",
            "Procrastinating 🕒",
            "Socializing 🤝",
            "Stressed 😫",
            "Studying 📖",
            "Tired 😴",
            "Working 💼",
            "Exploring the City 🏙️",
            "Conquering the Books 📚",
            "Creating Art 🎨",
            "Hitting the Gym 💪",
            "Making Memories 📸",
            "Attending a Concert 🎶",
            "Hiking the Trails 🌲",
            "Cooking up a Storm 🍳",
            "Learning Something New 🧠",
            "Jamming with Friends 🎸",
            "Volunteering for a Cause ❤️",
            "Getting Lost in a Movie 🎥",
            "Traveling the World ✈️",
            "Solving Puzzles 🔍",
            "Working on Projects 💼",
            "Chasing Dreams ✨",
            "Relaxing by the Beach 🏖️",
            "Embracing the Nightlife 🌃"
            // Add more statuses here if needed
        ]
        // Initialize Firebase and listen to authentication state changes
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.currentUser = user
                self.isLoggedIn = true
            } else {
                self.currentUser = nil
                self.isLoggedIn = false
            }
        }
    }
    
    // Firebase authentication methods
    func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // Add more Firebase-related functions for user data and settings
    
}

// Define a struct for user settings (if applicable)
struct UserSettings {
    // Define user settings properties here
}
