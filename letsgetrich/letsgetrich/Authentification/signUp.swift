import SwiftUI

struct SignUp: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmedpassword: String = ""
    @State private var selectedCollegeIndex = 0 // Initial selection
    
    let colleges = [
        "University of Georgia (UGA)",
        "Georgia State University",
        "Georgia Institute of Technology (Georgia Tech)",
        "Morehouse College",
        "Spelman College",
        "Emory University",
        "Georgia Southern University",
        "Kennesaw State University",
        "Mercer University",
        "Clark Atlanta University",
        "Agnes Scott College",
        "Savannah State University",
        "Georgia College & State University",
        "Columbus State University",
        "Georgia Southern University",
        "Valdosta State University",
        "Augusta University",
        "University of West Georgia",
        "Georgia Southwestern State University",
        "Georgia Gwinnett College",
        "Oglethorpe University",
        "Berry College",
        "Piedmont College",
        "Reinhardt University",
        "Wesleyan College",
        "University of North Georgia",
        "Albany State University",
        "Fort Valley State University",
        "Middle Georgia State University",
        "Clayton State University"
    ] // List of colleges in Georgia
    
    var body: some View {
        NavigationView {
            VStack {
                Image(colorScheme == .dark ? "OnCampDark" : "OnCampLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320, height: 120)
                    .padding()
                HStack {
                    Text("Sign")
                        .foregroundColor(Color.blue)
                        .padding(.trailing, -5.0)
                    Text("Up!")
                    
                }
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                Spacer()
                VStack {
                    TextField("Username", text: $username)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    TextField("Password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    TextField("Confirm Password", text: $confirmedpassword)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    Picker("Select a College", selection: $selectedCollegeIndex) {
                        ForEach(0..<colleges.count, id: \.self) { index in
                            Text(colleges[index])
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Use MenuPickerStyle for a dropdown-like appearance
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                }
                
                Spacer()
                
                Button(action: {
                    // Add your sign-up action here
                }) {
                    Text("Sign Up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .cornerRadius(8)
                        .background(.blue)
                }
                Spacer()
                
                Divider()
                
                NavigationLink(destination: SignIn()) {
                    HStack{
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color("LTBL"))
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SignUp()
                .preferredColorScheme(.light)
            SignUp()
                .preferredColorScheme(.dark)
        }
    }
}
