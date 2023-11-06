//
//  DetailedEvent.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/30/23.
//

import SwiftUI
import MapKit

struct DetailedEvent: View {
    var EventTitle: String
    var EventHost: String
    var EventLocation: String
    var EventParticipants: Int
    
    var images = [
        "Events1",
        "Events2",
        "Events3",
    ]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading){
                EventImageCarousel(images: images)
                    .frame(height: 320)
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .background {
                            Circle()
                                .fill(.white)
                                .frame(width:32, height: 32)
                        }
                        .padding(32)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(EventTitle)
                    .font(.title)
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        
                        
                        Text("2D 6H 3M")
                            .padding(.trailing, 8.0)
                        Image(systemName: "person")
                        Text(" \(EventParticipants)")
                        
                    }
                    .foregroundColor(Color("LTBL"))
                    
                    Text(EventLocation)
                }
                .font(.caption)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack{
                VStack{
                    Text("This Event is being hosted by \(EventHost)")
                        .font(.headline)
                        .frame(width:250, alignment: .leading)
                    HStack(spacing: 2) {
                        Text("Verified Event")
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                        
                    }
                    .frame(width:250, alignment: .leading)
                    .font(.caption)
                }
                .frame(width:300)
                
                Spacer()
                
                CircularProfilePictureView()
                    .frame(width: 64, height: 64)
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(0 ..< 2) { feature in
                    HStack(spacing: 12) {
                        Image(systemName: "wineglass")
                        
                        VStack(alignment: .leading) {
                            Text("BYOB")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Text("Aye man say man dont be on that freeloading shit bring your own drinks")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Ticket Packages")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(1 ..< 5) { ticket in
                            VStack {
                                Image(systemName: "ticket")
                                Text("Ticket \(ticket)")
                            }
                            .frame(width: 132, height:100)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }
            .padding()
            
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                Divider()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("What'll be there")
                        .font(.headline)
                    ForEach(0 ..< 5) { feature in
                        HStack {
                            Image(systemName: "plant")
                                .frame(width: 32)
                            
                            Text("GAS")
                                .font(.footnote)
                            
                            Spacer()
                        }
                    }
                }
                .padding()
                Text("Where the party's at")

                // Set the initial region for the map
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880), // Example coordinates, replace with actual event location
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )))
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .ignoresSafeArea()
        .padding(.bottom, 64)
        .overlay(alignment: .bottom) {
            VStack {
                Divider()
                    .padding(.bottom)
                HStack{
                    VStack(alignment: .leading){
                        Text("$15")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text("Total Before taxes")
                            .font(.footnote)
                        
                        Text("Nov 15")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .underline()
                    }
                    
                    Spacer()
                    
                    Button{
                        
                    } label: {
                        Text("Register")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 140, height: 40)
                            .background(.pink)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal, 32)
            }
            .background(.white)
        }
    }
}

struct DetailedEvent_Previews: PreviewProvider {
    static var previews: some View {
        DetailedEvent(
            EventTitle: "OnCamp Release Party",
            EventHost: "Best Parties ATL",
            EventLocation: "830 Westview Drive",
            EventParticipants: 520
        )
    }
}
