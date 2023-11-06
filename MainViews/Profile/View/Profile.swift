//
//  Profile.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct Profile: View {
    @EnvironmentObject var postData : PostData
    @State private var posts = [PostData.Post]()
   
    @State private var selectedFilter: ProfileTabFilter = .posts
    @Namespace var animation
    @EnvironmentObject var userData: UserData
    var currentUser: UserData.User?
   
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTabFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    var body: some View {
           ScrollView(showsIndicators: false) {
               VStack(spacing: 20) {
                   if let currentUser = userData.currentUser {
                                      ProfileHeaderCell(user: currentUser)
                                  
                   }
                    
                   
                   
                   Picker("Filter", selection: $selectedFilter) {
                       ForEach(ProfileTabFilter.allCases, id: \.self) { filter in
                           Text(filter.title).tag(filter)
                       }
                   }
                   .pickerStyle(SegmentedPickerStyle())
                   .padding()

                   // Dynamic content based on selected filter
                   switch selectedFilter {
                   case .posts:
                       PfpPosts(postData: PostData())
                   case .likes:
                       PfpLikes()
                   case .reposts:
                       PfpReposts()
                       
                   }

               }
               .padding(.horizontal)
           }
    }
    }
    
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(currentUser: UserData.User(id: loggedInUser,
                                          username: "MockUser123",
                                          bio: "This is a mock bio",
                                          status: "Chilling 😎",
                                          school: "Mock School",
                                          interests: ["Coding", "SwiftUI"],
                                          profilePictureURL: "https://example.com/mockprofile.jpg",
                                          followerCount: 120,
                                          followingCount: 150,
                                          postCount: 10,
                                          isVendor: false))
        
        .environmentObject(UserData())
        .environmentObject(PostData())
    }
}

