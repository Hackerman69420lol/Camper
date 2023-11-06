////
////  VendorData.swift
////  OnCampApp
////
////  Created by Michael Washington on 11/3/23.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//struct Vendor: Identifiable, Codable {
//    var id: String
//    var name: String
//    var description: String
//    var logoUrl: String
//    var products: [String] // Assuming this is an array of product IDs
//}
//
//struct Product: Identifiable, Codable {
//    var id: String
//    var name: String
//    var description: String
//    var imageUrl: String
//    var price: Double
//    var vendorId: String // Assuming each product is linked to a vendor
//}
//
//class VendorData: ObservableObject {
//
//    @Published var vendors: [Vendor] = []
//    @Published var products: [Product] = []
//
//    private let db = Firestore.firestore()
//
//    // Fetches all vendors from Firestore
//    func fetchVendors() async throws {
//        let querySnapshot = try await db.collection("vendors").getDocuments()
//        self.vendors = querySnapshot.documents.compactMap { document in
//            try? document.data(as: Vendor.self)
//        }
//    }
//
//    // Fetches all products for a specific vendor
//    func fetchProducts(forVendor vendorId: String) async throws {
//        let querySnapshot = try await db.collection("products")
//                                        .whereField("vendorId", isEqualTo: vendorId)
//                                        .getDocuments()
//        self.products = querySnapshot.documents.compactMap { document in
//            try? document.data(as: Product.self)
//        }
//    }
//
//    // Fetches a single vendor's information
//    func fetchVendor(withId id: String) async throws -> Vendor? {
//        let documentSnapshot = try await db.collection("vendors").document(id).getDocument()
//        return try? documentSnapshot.data(as: Vendor.self)
//    }
//
//
//    func deleteVendor(withId id: String) async throws {
//        try await db.collection("vendors").document(id).delete()
//    }
//
//
//    func addProductToVendor(_ productId: String, vendorId: String) async throws {
//        let vendorRef = db.collection("vendors").document(vendorId)
//        do {
//            try await db.runTransaction { transaction, _ in
//                let vendorDocument: DocumentSnapshot
//                do {
//                    try vendorDocument = transaction.getDocument(vendorRef)
//                } catch let fetchError as NSError {
//                    print("Error fetching document: \(fetchError.localizedDescription)")
//                    // Instead of throwing, we return nil to indicate failure
//                    return nil
//                }
//
//                guard var vendor = try? vendorDocument.data(as: Vendor.self) else {
//                    // Handle the error by logging or setting an error state
//                    print("Unable to fetch vendor data")
//                    // Return nil to indicate failure
//                    return nil
//                }
//
//                vendor.products.append(productId)
//                // If an error occurs here, we catch it and handle it similarly
//                do {
//                    try transaction.updateData(["products": vendor.products], forDocument: vendorRef)
//                } catch {
//                    print("Error updating vendor: \(error.localizedDescription)")
//                    return nil
//                }
//
//                // If everything is successful, return nil (which signifies no error in this context)
//                return nil
//            }
//        } catch let transactionError {
//            // If the transaction itself fails, then we can catch that error here and throw it if needed
//            throw transactionError
//        }
//    }
//
//}
