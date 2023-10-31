//
//  CreateMessage.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct CreateMessage: View {
    @ObservedObject var viewmodel = NewMessageViewModel()
    @Binding var showChatView: Bool
    
    @Environment(\.presentationMode) var mode
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                ForEach(viewmodel.users) { user in
                    Button(action: {
                        showChatView.toggle()
                        mode.wrappedValue.dismiss()
                    }, label: {
                        UserCell(user:user)
                    })
                }
            }
        }
    }
}

struct CreateMessage_Previews: PreviewProvider {
    static var previews: some View {
        CreateMessage(showChatView: .constant(true))
    }
}
