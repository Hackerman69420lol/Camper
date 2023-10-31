//
//  tabBar.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/13/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct tabBar: View {
    @State private var selectedtab = 0
    @ObservedObject var userData = UserData()
    @ObservedObject var postData = PostData()
    
   
    var body: some View {
        TabView(selection: $selectedtab) {
            Marketplace()
                .tabItem {
                    Image(systemName: selectedtab == 0 ? "bag.fill" : "bag")
                        .environment(\.symbolVariants, selectedtab == 0 ? .fill : .none)
                }
                .onAppear {selectedtab = 0}
                .tag(0)
            
            Social()
                .tabItem {
                    Image(systemName: selectedtab == 2 ? "trophy.fill" : "trophy")
                        .environment(\.symbolVariants, selectedtab == 1 ? .fill : .none)
                }
                .onAppear {selectedtab = 1}
                .tag(1)
            Feed()
                .tabItem {
                    Image(systemName: selectedtab == 2 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedtab == 2 ? .fill : .none)
                }
                .onAppear {selectedtab = 2}
                .tag(2)
            CreatePost()
                .tabItem {
                    Image(systemName: selectedtab == 3 ? "plus.bubble.fill" : "plus.bubble")
                        .environment(\.symbolVariants, selectedtab == 3 ? .fill : .none)
                }
                .onAppear {selectedtab = 3}
                .tag(3)
            Profile()
                .tabItem {
                    Image(systemName: selectedtab == 4 ? "person.circle.fill" : "person.circle")
                        .environment(\.symbolVariants, selectedtab == 4 ? .fill : .none)
                }
                .onAppear {selectedtab = 4}
                .tag(4)
        }.onAppear {
            Task {
                await userData.fetchUserData()
                
             
            
                
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    
    struct tabBar_Previews: PreviewProvider {
        static var previews: some View {
            tabBar()
        }
    }
}
