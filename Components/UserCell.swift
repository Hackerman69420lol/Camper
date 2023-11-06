import SwiftUI

struct UserCell: View {
    @EnvironmentObject var userData: UserData
        
        let user: UserData.User // Assuming User is your user model
    
    var body: some View {
        VStack {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.username) // Display the username from the User model
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(user.status) // Display the status from the User model
                        .font(.system(size: 15))
                  
                }
                .font(.footnote)
                .foregroundColor(Color("LTBL"))
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
}
