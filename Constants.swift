//
//  Constants.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/31/23.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseAuth

let loggedInUser = Auth.auth().currentUser!.uid
let db = Firestore.firestore()
let USER_COLLECTION = db.collection("Users")
let POST_COLLECTION = db.collection("Posts")
let CHAT_COLLECTION = db.collection("Chats")
let CHANNEL_COLLECTION = db.collection("Channels")
let EVENT_COLLECTION = db.collection("Events")

