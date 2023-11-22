//
//  EPUsername.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/18/23.
//

import SwiftUI

struct EPUsername: View {

    @Binding var username: String

       var body: some View {
           VStack {
               TextField("Username", text: $username)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

               Button("Save") {
                   // Implement save logic
               }
               .padding()
           }
           .navigationTitle("Edit Username")
       }
   }

struct EPUsername_Previews: PreviewProvider {
    static var previews: some View {
        EPUsername(username: .constant("SampleUsername"))
    }
}
