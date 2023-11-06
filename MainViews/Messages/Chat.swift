//
//  Chat.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI


struct ChatView: View {
    var userId: String


        @State private var messageText = ""
        
        var body: some View {
            VStack{
                ScrollView {
                    VStack(alignment: .leading, spacing:12) {
                        ForEach((0 ... 10), id: \.self) { _ in
                            DetailedChatBubbles(isFromCurrentUser: false)
                        }
                    }
                }
                CustomChatInput(text: $messageText, action: sendMessage)
            }
            .navigationTitle("UserName")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.vertical)
        }
        private func sendMessage() {
            print("Send Message \(messageText)")
            messageText = ""
        }
        // Replace with your actual chat view content
      
    

}

struct Chat_Previews: PreviewProvider {

    static var previews: some View {
        ChatView(userId: "757")
    }
}
