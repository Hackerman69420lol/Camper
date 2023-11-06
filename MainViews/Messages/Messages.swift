import SwiftUI

struct Messages: View {
    @State private var showChatView = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach((0...10), id: \.self) { _ in
                            NavigationLink(destination: ChatView(userId: "757")) {
                                MessageCell()
                            }
                        }
                    }
                }
               
               

                NavigationLink(destination: CreateMessage()) {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding()
                }
                .background(Color(.systemBlue))
                .foregroundColor(Color.white)
                .clipShape(Circle())
                .padding()
            }
        } .navigationTitle("Messages")
            .navigationBarBackButtonHidden()

    }
}


struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
    }
}
