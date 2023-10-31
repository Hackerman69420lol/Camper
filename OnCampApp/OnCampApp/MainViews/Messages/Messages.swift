//
//  Messages.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/16/23.
//

import SwiftUI

struct Messages: View {
    @State private var showNewMessageView = false
    @State private var showChatView = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            NavigationLink(
                destination: Chat(),
                isActive: $showChatView){ }
            
            ScrollView{
                VStack(alignment: .leading) {
                    ForEach((0 ... 10), id: \.self) { _ in
                        NavigationLink(destination: Chat(), label: {
                            MessageCell() })
                    }
                }
            }
            Button(action: {
                showNewMessageView.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(Color("LTBLALT"))
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showNewMessageView, content: {
                CreateMessage(showChatView: $showChatView)
            })
        }
        
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
    }
}
