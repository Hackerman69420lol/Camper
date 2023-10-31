//
//  Signoutbutton.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/13/23.
//

import SwiftUI
import Firebase

struct Signoutbutton: View {
    @ObservedObject var userData = UserData.shared
    var body: some View {
        Button("Signout") {
            signOut()   
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            // Successful sign-out
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
            
        }
    }

}

struct Signoutbutton_Previews: PreviewProvider {
    static var previews: some View {
        Signoutbutton()
    }
}
