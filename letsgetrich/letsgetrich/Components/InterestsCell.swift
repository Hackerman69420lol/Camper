//
//  InterestsCell.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/16/23.
//

import SwiftUI

struct InterestsCell: View {
    var interests: String
    
    var body: some View {
        Text(interests)
            .padding()
            .foregroundColor(Color("LTBL"))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .cornerRadius(8)
            .padding(.trailing, 8)
    }
}

struct InterestCell_Previews: PreviewProvider {
    static var previews: some View {
        InterestsCell(interests: "geeked")
    }
}
