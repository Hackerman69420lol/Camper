//
//  File.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/7/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Vendor: Identifiable {
    var id: UUID = .init()
    var description: String
    var schools : [String]
    var name: String
    var image: String
    var category: String
    var rating: Double
    var color: Color
    var products: [Product]  // Assuming `Product` is also a defined type
}

// Assuming `productList` is defined elsewhere and accessible here
var vendorList = [
    Vendor(
        description: "Best Vendor there is",
        schools: ["morehouse", "spelman", "clark atlanta"],
        name: "Vendor One",
        image: "vendorOneImage",
        category: "AUCS",
        rating: 4.5,
        color: .blue,
        products: productList
    ),
    Vendor(
        description: "Best Vendor there is",
        schools: ["morehouse", "spelman", "clark atlanta"],
        name: "Vendor Two",
        image: "vendorTwoImage",
        category: "store",
        rating: 1,
        color: .blue,
        products: productList
    ),
    Vendor(
        description: "Best Vendor there is",
        schools: ["morehouse", "spelman", "clark atlanta"],
        name: "Vendor three",
        image: "vendorThreeImage",
        category: "other",
        rating: 3,
        color: .blue,
        products: productList
    )
]

class VendorData: ObservableObject{
    
    init(){
        Task{
            try await fetchVendors()
        }
    }
    
    func fetchVendors() async {
        
     
      do {
            let querySnapshot = try await VENDOR_COLLECTION.getDocuments()

            let vendorIDs = querySnapshot.documents.map { $0.documentID }
//            return vendorIDs
            
           print (vendorIDs)
        } catch {
            print("Error fetching user-specific post IDs: \(error.localizedDescription)")


        }
        
    }

}
