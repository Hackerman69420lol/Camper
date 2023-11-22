//
//  EPStatis.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/18/23.
//

import SwiftUI

struct EPStatis: View {
    @Binding var status: String

        var body: some View {
            VStack {
                TextField("Status", text: $status)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Save") {
                    // Implement save logic
                }
                .padding()
            }
            .navigationTitle("Edit Status")
        }
    }

struct EPStatis_Previews: PreviewProvider {
    static var previews: some View {
        EPStatis(status: .constant("SampleStatus"))
    }
}
