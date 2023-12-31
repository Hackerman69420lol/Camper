//
//  CMPreviewBox.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct CMPreviewBox: View {
    var body: some View {
        
        NavigationStack() {
            VStack {
                ZStack {
                    Rectangle() // Smaller rectangle on top
                        .fill(Color("OnCampSky")) // Adjust color as needed
                        .frame(width: 400, height: 210)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Rectangle() // Smaller rectangle on top
                        .fill(Color("LTBLALT")) // Adjust color as needed
                        .frame(width: 355, height: 190)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack{
                        
                        
                        NavigationLink(destination: MessagesTabBar()) {
                            Text("View All")
                            
                            
                        }
                        
                        
                        CMCells()
                        
                    }
                    
                }
            }
        }
    }
}

struct CMPreviewBox_Previews: PreviewProvider {
    static var previews: some View {
        CMPreviewBox()
    }
}
