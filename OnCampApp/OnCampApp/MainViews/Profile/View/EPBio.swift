//
//  EPBio.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/18/23.
//

import SwiftUI

struct EPBio: View {
    @Binding var bio: String

        var body: some View {
            VStack {
                TextEditor(text: $bio)
                    .frame(minHeight: 100)
                    .padding()

                Button("Save") {
                    // Implement save logic
                }
                .padding()
            }
            .navigationTitle("Edit Bio")
        }
    }

struct EPBio_Previews: PreviewProvider {
    static var previews: some View {
        EPBio(bio: .constant("SampleBio"))
    }
}
