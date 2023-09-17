//
//  ContentView.swift
//  letsgetrich
//
//  Created by Michael Washington on 8/28/23.
//

import SwiftUI


struct SignIn: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Image(colorScheme == .dark ? "OnCampDark" : "OnCampLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320,height: 120)
                    .padding()
                
                HStack {
                    Text("Welcome")
                    Text("On")
                        .foregroundColor(Color.blue)
                        .padding(.trailing, -5.0)
                    Text("Camp!")
                    
                }
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                Spacer()
                VStack {
                    TextField("Enter Your Email", text: $email)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal,24)
                    SecureField("Enter Your Password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal,24)
                }
                
                
                NavigationLink{
                    forgotPassword()
                }   label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .foregroundColor(Color("LTBL"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                Spacer()
                
                Button {
                    
                }label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .cornerRadius(8)
                        .background(.blue)
                }
                Spacer()
                
                Divider()
                    .foregroundColor(Color("LTBL"))
                
                NavigationLink{
                    SignUp()
                }   label: {
                    HStack{
                        Text("Dont have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color("LTBL"))
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group
            {
                SignIn()
                    .preferredColorScheme(.light)
                SignIn()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
