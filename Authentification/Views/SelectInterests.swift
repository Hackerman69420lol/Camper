//
//  Select Interests.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/9/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct Interests: View {
    var uid: String
    @EnvironmentObject var userData : UserData
    @State private var selectedInterests: Set<String> = []
    @State private var navigate = false // This controls the navigation
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Your other UI elements...
                    
                    ForEach(userData.interests, id: \.self) { interest in
                        Toggle(isOn: Binding(
                            get: { selectedInterests.contains(interest) },
                            set: { isSelected in
                                if isSelected {
                                    selectedInterests.insert(interest)
                                } else {
                                    selectedInterests.remove(interest)
                                }
                            }
                        )) {
                            Text(interest)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Select Interests")
            .navigationDestination(isPresented: $navigate) {
                tabBar()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task{
                                do {
                                    try await collectInterests(selectedInterests:  selectedInterests)
                                } catch {
                                    // Handle errors from fetchRepostedPosts here
                                    print("Error fetching reposted posts: \(error)")
                                }
                            }
                           
                        }) {
                            Text("Save")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
    
    func collectInterests( selectedInterests: [String]) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            let documentRef = USER_COLLECTION.document(loggedInUser)
            documentRef.updateData([
                "interests": selectedInterests
            ]) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    self.navigate = true // Assuming this is defined somewhere relevant
                    continuation.resume(returning: ())
                }
            }
        }
    }
    func collectInterests(selectedInterests: Set<String>) async throws {
        // Since we now have a set, we convert it to an array before passing it to Firestore.
        let interestsArray = Array(selectedInterests)
        
        return try await withCheckedThrowingContinuation { continuation in
            let documentRef = USER_COLLECTION.document(loggedInUser) // Make sure `uid` is the correct ID
            documentRef.updateData([
                "interests": interestsArray
            ]) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    self.navigate = true
                    continuation.resume(returning: ())
                }
            }
        }
    }
}





struct Interests_Previews: PreviewProvider {
    static var previews: some View {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            return Interests(uid: uid)
                .environmentObject(UserData()) // Add the environment object here
        }
        
        // Fallback preview for a non-logged-in user
        return Interests(uid: "MjtdfqAyCuhOE8S8MbigBT9okXN2")
            .environmentObject(UserData()) // Add the environment object here
    }
}
