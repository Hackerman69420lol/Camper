//
//  ProfileTabFilter.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/15/23.
//

import Foundation

enum ProfileTabFilter: Int, CaseIterable, Identifiable {
    case posts
    case likes
    case reposts
    
    var title: String {
        switch self {
        case .posts: return "Posts"
        case .likes: return "Likes"
        case .reposts: return "Reposts"
        }
    }
    var id: Int { return self.rawValue}
}
