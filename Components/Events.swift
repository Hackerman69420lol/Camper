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
                
                LazyVStack(spacing: 32) {
                    ForEach(0 ... 10, id: \.self) { events in
                        NavigationLink(value: events) {
                             EventPreview()
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { events in
                DetailedEvent(EventTitle: "eventtitle", EventHost: "AUCS", EventLocation: "here", EventParticipants: 12)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
