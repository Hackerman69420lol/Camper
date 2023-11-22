//
//  SideMenuHeader.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/16/23.
//

import SwiftUI

struct SideMenuHeader: View {
    @Binding var showingMenu: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                CircularProfilePictureView()
                    .frame(width: 64, height: 64)
                Spacer()
                Button(action: {
                    // Toggles the showingMenu state
                    withAnimation {
                        showingMenu.toggle()
                        print("menu toggled")
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            
            HStack {
                Text("AUC Loverbird")
                    .font(.system(size: 24, weight: .semibold))
                
                Image(systemName: "v.circle.fill")
                    .foregroundColor(Color("OnCampSky"))
            }
            
            Text("@OnCampOfficial")
                .font(.system(size: 14))
                .padding(.bottom, 24)
            
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Text("1,254").bold()
                    Text("Following")
                }
                HStack(spacing: 4) {
                    Text("607").bold()
                    Text("Followers")
                }
                Spacer()
            }
            Spacer()
        }.padding()
    }
}

//struct SideMenuHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuHeader(showingMenu: $showingMenu)
//    }
//}
