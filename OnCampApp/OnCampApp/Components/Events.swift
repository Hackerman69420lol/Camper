//
//  Events.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/28/23.
//

import SwiftUI

struct Events: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Trending Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("LTBL"))
                
                EventCategoryList()
                LazyVStack(spacing: 32) {
                    ForEach(0 ... 10, id: \.self) { events in
                        NavigationLink(destination: DetailedEvent(EventTitle: "", EventHost: "", EventLocation: "", EventParticipants: 4)) {
                            EventPreview()
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { events in
                DetailedEvent(EventTitle: "", EventHost: "", EventLocation: "", EventParticipants: 4)
            }
        }
    }
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
