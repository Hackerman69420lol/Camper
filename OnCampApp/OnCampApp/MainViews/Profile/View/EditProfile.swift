//
//  editProfileView.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/16/23.
//

import SwiftUI
import PhotosUI

struct editProfileView: View {
    @State private var selectedImage: PhotosPickerItem?
    @State private var username = ""
    @State private var bio = ""
    @State private var status = ""
    @State private var school =  ""
    @State private var interests = []
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $selectedImage) {
                    VStack {
                        Image(systemName: "person")
                            .resizable()
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                        Text("Edit Profile Picture")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Divider()
                    }
                }
                .padding(.vertical, 8)
                
                VStack {
                    EditProfileRow(title: "Username", destination: EPUsername(username: $username))
                    EditProfileRow(title: "Bio", destination: EPBio(bio: $bio))
                    EditProfileRow(title: "Status", destination: EPStatis(status: $status))
                }
                Spacer()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        
                    }
                    .font(.subheadline)
                    .foregroundColor(Color("LTBL"))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("LTBL"))
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct EditProfileRow<Destination: View>: View {
    let title: String
    let destination: Destination
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            NavigationLink(destination: destination) {
                Text("Edit")
                    .padding(.trailing, 8)
                Spacer()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}


struct editProfileView_Previews: PreviewProvider {
    static var previews: some View {
        editProfileView()
    }
}
