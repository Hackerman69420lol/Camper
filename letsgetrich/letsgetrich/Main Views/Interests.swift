//
//  Interests.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/16/23.
//

import SwiftUI

struct InterestsView: View {
    var interests = [
        "Staying in", "Going out", "Eating out", "Drinking",
        "Smoking", "Sports", "Reading", "Movies",
        "Music", "Gaming", "Writing", "Food",
        "Fashion", "Cars", "Parties",
        "Staying home", "Traveling", "Cooking", "Socializing",
        "Hiking", "Exercise", "Learning", "Concerts",
        "Art", "Tech", "Nature", "Dancing",
        "Photography", "Pets", "Adventure", "Beach",
        "Yoga", "Exploring", "Meditation", "Shopping",
        "Volunteering", "Singing", "Crafts", "Poetry"
    ]
    private var numberOfRows: Int {
        return (interests.count + 2) / 3
    }
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        VStack {
                            Text("Status")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("LTBL"))
                            
                            Text("Let everyone know how you're feeling")
                                .font(.subheadline)
                                .foregroundColor(Color("LTBL"))
                            
                            Text("Please select 3 interests!")
                                .font(.subheadline)
                                .foregroundColor(Color("LTBL"))
                            
                            Spacer() // Add vertical spacing
                            
                            VStack(spacing: 20) { // Add vertical spacing between rows
                                ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                                    HStack {
                                        ForEach(0..<3) { columnIndex in
                                            let index = rowIndex * 3 + columnIndex
                                            if index < interests.count {
                                                ZStack {
                                                    Color.clear
                                                    
                                                    Text(interests[index])
                                                        .frame(width: 100, height: 60)
                                                        .background(Color.white)
                                                        .cornerRadius(8)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color.gray, lineWidth: 1)
                                                        )
                                                }
                                            } else {
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    // Handle the Finish button action here
                    // This is where you can implement logic for finishing the selection
                }) {
                    Text("Finish")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .cornerRadius(8)
                })
            }
        }
    }

struct InterestsView_Previews: PreviewProvider {
    static var previews: some View {
        InterestsView()
    }
}
