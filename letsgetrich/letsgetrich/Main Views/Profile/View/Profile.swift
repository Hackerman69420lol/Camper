//
//  Profile.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/11/23.
//

import SwiftUI

struct Profile: View {
    @State private var selectedFilter: ProfileTabFilter = .posts
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTabFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("AUC Lovebirds")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                            Text("@OnCampOfficial")
                            .font(.subheadline)
                        }
                       
                        Text("YRN")
                            .font(.footnote)
                    
                        Text("5000 followers")
                            .font(.caption)
                            .foregroundColor(Color("LTBL"))
                }
                
                Spacer()
                
                CircularProfilePictureView()
            }
            
            Button {
                
            } label: {
                Text("Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("LTBLALT"))
                    .frame(width: 352, height: 32)
                    .background(Color("LTBL"))
                    .cornerRadius(8)
                }
                VStack {
                    HStack {
                        ForEach(ProfileTabFilter.allCases) { filter in
                            VStack {
                                Text(filter.title)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                
                                if selectedFilter == filter {
                                    Rectangle()
                                        .foregroundColor(Color("LTBL"))
                                        .frame(width: filterBarWidth, height: 1)
                                        .matchedGeometryEffect(id: "item", in: animation)
                                    
                                } else {
                                    Rectangle() 
                                        .foregroundColor(.clear)
                                        .frame(width: filterBarWidth, height: 1)
                                }
                            }
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedFilter = filter
                                }
                            }
                        }
                    }
                    LazyVStack {
                        ForEach(0 ... 10, id: \.self) { thread in
                            PostCell()
                        }
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
