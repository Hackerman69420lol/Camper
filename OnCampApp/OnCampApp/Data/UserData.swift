
// UserData.swift
// OnCampRelease
//
// Created by Michael Washington on 9/20/23.
//

import Foundation
import SwiftUI
import Firebase
import Combine
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore




struct User: Identifiable, Codable {
        var id: String { uid } // Conforming to Identifiable
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
}

class UserData:ObservableObject{
    
   
    
    @Published var bio: String = ""
    @Published var username: String = ""
    @Published var status: String = ""
    @Published var school: String = ""
    @Published var interests: [String] = [] // Changed from String to [String]
    @Published var profilePictureURL: String = ""
    @Published var followerCount: Int = 0
    @Published var favorites: Int = 0
    @Published var followingCount: Int = 0
    @Published var postCount: Int = 0
    @Published var isVendor: Bool = false // changed from "IsVendor" to "isVendor"
    
    
    @Published var statuses: [String] = []
    @Published var colleges: [String] = []
    @Published var alertMessage: String = ""
    @Published var showingAlert: Bool = false
    static let shared = UserData()
    var uid: String = ""
    var profileImage: UIImage?
    @Published var isLoggedIn: Bool = false
    @State var signupSuccessful: Bool = false
    @Published var currentUser: User?

    init() {
        
 
        
        self.colleges = [
            "Morehouse College",
            "Spelman College",
            "Clark Atlanta University",
            "University of Georgia (UGA)",
            "Georgia State University",
            "Georgia Institute of Technology (Georgia Tech)",
            "Emory University",
            "Georgia Southern University",
            "Kennesaw State University",
            "Mercer University",
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
        self.interests = [
         "Staying in","Going out", "Eating out","Drinking",
        "Smoking", "Sports", "Reading", "Movies",
        "Music", "Gaming", "Writing", "Food",
        "Fashion", "Cars", "Parties",
        "Staying home", "Traveling", "Cooking", "Socializing",
        "Hiking", "Exercise", "Learning", "Concerts",
        "Art", "Tech", "Nature", "Dancing",
        "Photography", "Pets", "Adventure", "Beach",
        "Yoga", "Exploring", "Meditation", "Shopping",
        "Volunteering", "Singing", "Crafts", "Poetry"

        ]
        // Initialize Firebase and listen to authentication state changes
    }

    func fetchUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No authenticated user found")
            // Handle the case where there is no authenticated user
            return
        }

        let db = Firestore.firestore()

        do {
            let document = try await db.collection("Users").document(uid).getDocument()

            if document.exists {
                let data = document.data() ?? [:]
                DispatchQueue.main.async {
                    self.username = data["username"] as? String ?? ""
                    self.postCount = data["postCount"] as? Int ?? 0
                    self.followerCount = data["followerCount"] as? Int ?? 0
                    self.followingCount = data["followingCount"] as? Int ?? 0
                    self.status = data["status"] as? String ?? ""
                    self.school = data["school"] as? String ?? ""
                    self.bio = data["bio"] as? String ?? ""
                }
            } else {
                print("Document does not exist")
            }
        } catch {
            print("Error fetching document: \(error)")
        }
    }


}



