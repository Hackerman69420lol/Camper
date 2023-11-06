
//
//  ChatData.swift
//  OnCampApp
//
//  Created by User on [Your Creation Date Here].
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine
import FirebaseFirestoreSwift

class ChatData: ObservableObject {
    
    @Published var hasFetchedChats = false
    
    struct ChatDetail {
        var id: String // The ID of the chat
        var mostRecentMessage: Message // The most recent message of the chat
        var otherParticipant: String // The ID of the other user in the chat
        var hasBeenRead: Bool // Indicates if the most recent message has been read
    }
    
    struct Chat: Identifiable, Codable {
        var id: String
        var timestamp: Date
        var participants: [String]
    }
    
    struct Message: Identifiable, Codable {
        var id: String
        var senderUid: String
        var content: String
        var timestamp: Date
        var read: Bool
    }
    
    // Fetch and store the latest 20 chat IDs for the user
    func fetchAndStoreChatIDs(userId: String) async throws {
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection("users").document(userId)
            .collection("chats").order(by: "timestamp", descending: true).limit(to: 20)
            .getDocuments()
        
        let chatIDs = querySnapshot.documents.map { $0.documentID }
        
        // Store the chat IDs in UserDefaults
        UserDefaults.standard.set(chatIDs, forKey: "\(userId)_chatIDs")
    }
    
    // Get cached chat IDs from UserDefaults
    func getCachedChatIDs(for userId: String) -> [String]? {
        return UserDefaults.standard.array(forKey: "\(userId)_chatIDs") as? [String]
    }
    
    // Listen for new chat documents and update UserDefaults
    func listenForNewChats(userId: String, completion: @escaping ([String]?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("chats")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error listening for chat updates: \(error?.localizedDescription ?? "No error")")
                    completion(nil)
                    return
                }
                
                let chatIDs = snapshot.documents.map { $0.documentID }
                
                if let cachedChatIDs = self.getCachedChatIDs(for: userId), cachedChatIDs != chatIDs {
                    UserDefaults.standard.set(chatIDs, forKey: "\(userId)_chatIDs")
                    completion(chatIDs)
                }
            }
    }
    
    // Fetch chats for the user and call the completion handler with the results
    // Fetch chats for the user and call the completion handler with the results
    func fetchUserChats(userId: String, completion: @escaping ([ChatDetail]?) -> Void) {
        if let cachedChatIDs = getCachedChatIDs(for: userId) {
            Task {
                let chatDetails = await self.fetchChats(with: cachedChatIDs, for: userId)
                completion(chatDetails)
            }
        } else {
            Task {
                do {
                    try await fetchAndStoreChatIDs(userId: userId)
                    if let newCachedChatIDs = self.getCachedChatIDs(for: userId) {
                        let chatDetails = await self.fetchChats(with: newCachedChatIDs, for: userId)
                        completion(chatDetails)
                    }
                } catch {
                    print("Error fetching chats: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }

    // Fetch chats using a list of chat IDs
    func fetchChats(with chatIDs: [String], for currentUserID: String) async -> [ChatDetail] {
        let db = Firestore.firestore()
        var chatDetails: [ChatDetail] = []

        for chatID in chatIDs {
            let messagesQuerySnapshot = try? await db.collection("chats").document(chatID)
                .collection("messages").order(by: "timestamp", descending: true).limit(to: 1)
                .getDocuments()

            if let mostRecentMessageDocument = messagesQuerySnapshot?.documents.first,
               let mostRecentMessage = try? mostRecentMessageDocument.data(as: Message.self),
               let chatDocument = try? await db.collection("chats").document(chatID).getDocument(),
               let chat = try? chatDocument.data(as: Chat.self) {
                
                let otherParticipant = chat.participants.first(where: { $0 != currentUserID })

                let detail = ChatDetail(
                    id: chatID,
                    mostRecentMessage: mostRecentMessage,
                    otherParticipant: otherParticipant ?? "Unknown",
                    hasBeenRead: mostRecentMessage.read || mostRecentMessage.senderUid == currentUserID
                )

                chatDetails.append(detail)
            }
        }

        return chatDetails
    }

    
    // Fetch chats with up-to-date chat IDs, update cache if new chats are fetched
    func fetchChats(userId: String) async throws -> [Chat] {
        let db = Firestore.firestore()
        let cachedChatIDs = getCachedChatIDs(for: userId) ?? []
        
        let chatDocuments = try await db.collection("chats")
            .whereField("participants", arrayContains: userId)
            .order(by: "timestamp", descending: true)
            .limit(to: 20)
            .getDocuments()
        
        let chats = chatDocuments.documents.compactMap { document in
            try? document.data(as: Chat.self)
        }
        
        let fetchedChatIDs = chats.map { $0.id }
        if fetchedChatIDs != cachedChatIDs {
            UserDefaults.standard.set(fetchedChatIDs, forKey: "\(userId)_chatIDs")
        }
        
        return chats
    }
    
    // Post a message to a chat in Firestore
    func postMessage(chatId: String, message: Message) async throws {
        let db = Firestore.firestore()
        let chatRef = db.collection("chats").document(chatId)
        let messageRef = chatRef.collection("messages").document()
        
        let batch = db.batch()
        let messageData: [String: Any] = [
            "id": messageRef.documentID,
            "senderUid": message.senderUid,
            "content": message.content,
            "timestamp": Timestamp(date: message.timestamp),
            "read": message.read
        ]
        
        // Add message to the batch
        batch.setData(messageData, forDocument: messageRef)
        
        // Update the chat's last message timestamp to ensure it shows up properly in lists
        batch.updateData(["lastMessageTimestamp": Timestamp(date: message.timestamp)], forDocument: chatRef)
        
        // Commit the batch write to Firestore
        try await batch.commit()
    }
    
    

   



    func getOrCreateChatID(with otherUserID: String, currentUserID: String) async throws -> String {
        let db = Firestore.firestore()

        // Get the potential existing chat document from the current user's "chats" subcollection
        let documentSnapshot = try await db.collection("Users").document(currentUserID).collection("chats").document(otherUserID).getDocument()

        // Check if the document exists
        if documentSnapshot.exists {
            // If a chat document exists, return its ID
            return documentSnapshot.documentID
        } else {
            // If not, create a new chat in the "Chats" collection
            let newChatData: [String: Any] = [
                "participants": [currentUserID, otherUserID],
                "timestamp": FieldValue.serverTimestamp()
            ]
            let newChatRef = try await db.collection("Chats").addDocument(data: newChatData)
            let chatID = newChatRef.documentID

            // Add a reference to the new chat in both users' "chats" subcollections
            let currentUserChatRef = db.collection("Users").document(currentUserID).collection("chats").document(otherUserID)
            let otherUserChatRef = db.collection("Users").document(otherUserID).collection("chats").document(currentUserID)
            
            // Prepare the chat data for the "chats" subcollection
            let chatReferenceData: [String: Any] = [
                "chatID": chatID,
                "lastMessageTimestamp": FieldValue.serverTimestamp()
            ]

            // Perform batched write to add chat references to both users' "chats" subcollections
            let batch = db.batch()
            batch.setData(chatReferenceData, forDocument: currentUserChatRef)
            batch.setData(chatReferenceData, forDocument: otherUserChatRef)

            // Commit the batch write
            try await batch.commit()

            // Return the new chat ID
            return chatID
        }
    }


    }


    


