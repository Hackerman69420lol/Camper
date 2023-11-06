
// UserData.swift
// OnCampRelease
//
// Created by Michael Washington on 9/20/23.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


@MainActor
class UserData: ObservableObject {

    @Published var currentUser: User?
    
    static let shared = UserData()
    private let db = Firestore.firestore()

    var interests: [String]
    var colleges: [String]
    var statuses: [String]
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
            "Kennesaw/Users/mikey/Desktop/S & W/Apps/OnCamp/OnCampApp/OnCampApp/MainViews/TabBar State University",
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
    }
    
    func fetchCurrentUser() async {
            guard currentUser == nil else { return } // Avoid refetching if already fetched
            guard let userId = Auth.auth().currentUser?.uid else { return }

            await fetchUserData(userId: userId)
        }
    
    func fetchUserData(userId: String) async {
          
           let userDocument = db.collection("Users").document(userId)

           do {
               let documentSnapshot = try await userDocument.getDocument()
               // Decode the user data into the User model
               // Make sure your User struct conforms to Decodable or is a FirestoreDataConvertible.
               if let user = try? documentSnapshot.data(as: User.self) {
                   DispatchQueue.main.async { [weak self] in
                       self?.currentUser = user
                   }
               } else {
                   print("User document does not exist or the data is not in the correct format.")
               }
           } catch {
               print("Error fetching user data: \(error.localizedDescription)")
           }
       }
    @Published var username: String = ""
    @Published  var bio: String = ""
    @Published  var status: String = ""
    @Published var school: String = ""
    
    // Add other user-related methods here, such as `updateUserProfile`, `fetchUserFollowers`, etc.
    
    struct User: Identifiable, Codable {
        @DocumentID var id: String?
        var username: String
        var bio: String
        var status: String
        var school: String
        var interests: [String]
        var profilePictureURL: String?
        var followerCount: Int
        var followingCount: Int
        var postCount: Int?
        var isVendor: Bool

    }
   
    
}


   
    // Initialize Firebase and listen to authentication state changes

