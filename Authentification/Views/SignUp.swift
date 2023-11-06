//
//  SignUp.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/9/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase

struct SignUp: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @State private var signUpSuccesful: Bool = false
    @State private var currentUser: User?
    @State private var shouldNavigateToCreateAccount = false
    
    var body: some View {
        
        
        NavigationStack {
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
                    TextField("Email", text: $email)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    SecureField("Password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    SecureField("Confirm Password", text: $confirmedPassword)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                }
                
                Spacer()
                Button(action: {
                    if password == confirmedPassword {
                        Task{
                            do {
                                try await signUp(email: email, password: password)
                        
                             
                            } catch {
                                // Handle errors from fetchRepostedPosts here
                                print("Error fetching reposted posts: \(error)")
                            }
                        }
                    }else{
                    
                        print("signup failed" )
                    }
                    
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
        .navigationDestination(isPresented: $shouldNavigateToCreateAccount) {
            CreateAccount(uid: loggedInUser)
        }
    }
    
    func signUp(email: String, password: String) async throws {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            // Assuming you set the uid somewhere after successful sign up
        if (loggedInUser == authResult.user.uid){
            self.shouldNavigateToCreateAccount = true
        }// Activate the NavigationLink
        }

    
    
    
}


struct SignUpView: PreviewProvider {
    static var previews: some View {
        Group{
            SignUp()
                .preferredColorScheme(.light)
             
            SignUp()
                .preferredColorScheme(.dark)
          
        }
    }
}
