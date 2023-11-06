import SwiftUI
import Firebase
import FirebaseFirestore

struct CreateMessage: View {
    @State private var users: [UserData.User] = []
    @State private var searchText = ""
    @ObservedObject private var chatData = ChatData()

    // Custom View for displaying filtered users
    struct FilteredUserCell: View {
        let user: UserData.User
        var createChat: (UserData.User) -> Void

        var body: some View {
            Button(action: {
                createChat(user)
            }) {
                UserCell(user: user)
            }
        }
    }

    // Function to fetch users from Firestore
    func fetchUsers() {
        let db = Firestore.firestore()
        db.collection("Users").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.users = documents.compactMap { document in
                    try? document.data(as: UserData.User.self)
                }
            }
        }
    }

    // Computed property to filter users based on search text
    var filteredUsers: [UserData.User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.username.lowercased().contains(searchText.lowercased()) }
        }
    }

    // Function to initiate creating a chat
    private func createChat(with user: UserData.User) {
        // Assume that we have a current user ID from somewhere in the app context
        let currentUserID = "currentUserID" // Replace with actual current user ID logic

        // This part should be called when a user cell is clicked
        Task {
            do {
                let chatId = try await chatData.getOrCreateChatID(with: user.id!, currentUserID: currentUserID)
                // Now navigate to ChatView with the obtained chatId
                // You would need to implement the navigation programmatically
            } catch {
                print(error.localizedDescription)
                // Handle errors appropriately
            }
        }
    }

    // Main body for the View
    var body: some View {
        NavigationView {
            List(filteredUsers) { user in
                FilteredUserCell(user: user, createChat: createChat)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .onAppear {
                fetchUsers()
            }
        }
        .navigationTitle("Create a Message")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

// SwiftUI Preview for the View
struct CreateMessage_Previews: PreviewProvider {
    static var previews: some View {
        CreateMessage()
    }
}
