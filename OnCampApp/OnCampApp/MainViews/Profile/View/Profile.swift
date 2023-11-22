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
    @ObservedObject var postData = PostData()
    @State private var posts = [PostData.Post]()
    @ObservedObject var userData = UserData()
    @State private var selectedFilter: ProfileTabFilter = .posts
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTabFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
   
        var body: some View {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        ProfileHeaderCell()

                        // Segmented control for filtering
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(ProfileTabFilter.allCases, id: \.self) { filter in
                                Text(filter.title).tag(filter)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)

                        // Content based on selected filter
                        switch selectedFilter {
                        case .posts:
                            PfpPosts()
                        case .likes:
                            PfpLikes()
                        case .reposts:
                            PfpReposts()
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .padding(.horizontal)
        }
    }



struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
