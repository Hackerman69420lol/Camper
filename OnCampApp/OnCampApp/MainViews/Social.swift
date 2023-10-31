import SwiftUI

struct Social: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack {
                    NavigationLink(destination: Notifications()) {
                        
                        HStack {
                            Spacer()
                            Image(systemName: "bell")
                                .font(.system(size: 24))
                        }
                        .padding(.trailing, 10.0)
                    }
                    Search()
                    
                
                    
                    CMPreviewBox()
                        .padding(.top, 11.0)
                    
               
                    
                    Events()
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .padding(.bottom, 20)
            }
            
        }
    }
}



struct Social_Previews: PreviewProvider {
    static var previews: some View {
        Social()
    }
}
