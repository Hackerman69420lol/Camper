//
//  MessageData.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import Foundation
import FirebaseFirestore
import Firebase

class MessageData: ObservableObject {
    
    struct Message {
        var senderUid: String
        var messageText: String
        var timeSent: Date
        var messageRead: Bool
        var messageReadAt: Date
    }
    
    @Published var senderUid: String = ""
    @Published var messageText: String = ""
    @Published var timeSent: Date = Date()
    @Published var messageRead: Bool = false
    @Published var messageReadAt: Date = Date()
    
    func sendMessage()
    {
        
    }
    let db = Firestore.firestore()
       
       func fetchUserIDs(completion: @escaping ([String]?) -> Void) {
           db.collection("Users").getDocuments { (snapshot, error) in
               if let error = error {
                   print("Error fetching user IDs: \(error.localizedDescription)")
                   completion(nil)
               } else if let documents = snapshot?.documents {
                   let userIDs = documents.compactMap { $0.documentID }
                   completion(userIDs)
               } else {
                   completion([])
               }
           }
       }
    
    
    
}
