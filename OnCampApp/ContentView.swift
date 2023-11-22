//
//  ContentView.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/10/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var userData = UserData()
    
    var body: some View {
        NavigationStack(root: {
            if Auth.auth().currentUser != nil {
                tabBar()
                // User is authenticated, show the main app content
            } else {
                Landing()
                // User is not authenticated, show a login/signup view
            }
        })
        .toolbar(.hidden)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
