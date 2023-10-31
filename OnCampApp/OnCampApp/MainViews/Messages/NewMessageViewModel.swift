//
//  NewMessageViewModel.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/31/23.
//

import Foundation
import Firebase
class NewMessageViewModel: ObservableObject {
   @Published var users = [User]()
    
    init(){
    fetchUsers()
    }
    func fetchUsers(){
        USER_COLLECTION.getDocuments {snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
            
            print(self.users)
        }
    }
}
