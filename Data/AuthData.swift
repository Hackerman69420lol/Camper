//
//  AuthData.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/3/23.
//
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    var uid: String? // Store the user's UID
    @Published var navigate: Bool? // Assuming this is a state variable used for UI navigation
    var isAccountCreated: Bool = false // Track if the account is created
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmedPassword: String = ""
    private init() {}

    // The signUp function now includes the parameter list and error handling
    func signUp(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    // The signIn function now includes the parameter list and error handling
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }


    // The collectInterests function now includes the parameter list and error handling
    
    // The createUserProfile method signature remains commented out as it's unclear what it's supposed to do

    // The createAccount function now includes error handling and async patterns
    func createAccount(bio: String, username: String, school: String, status: String, followerCount: Int, followingCount: Int, isVendor: Bool) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User is not logged in"])
        }
        let userRef = USER_COLLECTION.document(uid)
        let usernameRef = Firestore.firestore().collection("Usernames").document(username)
        
        let userData = [
            "bio": bio,
            "username": username,
            "school": school,
            "status": status,
            "isVendor": isVendor,
            "followingCount": followingCount,
            "followerCount": followerCount,
        ] as [String: Any]
        
        try await userRef.setData(userData)
        try await usernameRef.setData(["uid": uid])
        
        self.isAccountCreated = true
    }
}


