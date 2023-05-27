//
//  HomeViewModel.swift
//  car park
//
//  Created by Daan Vanhekken on 03/11/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class HomeViewModel: ObservableObject {
    @Published var homes = [Home]()
    
    private var db = Firestore.firestore()
    
    let userUID = Auth.auth().currentUser?.uid
    
    func fetchData() {
        guard let userUID = userUID else { return }

       
        db.collection("homes").whereField("user_uid", isEqualTo: userUID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.homes = documents.compactMap { document in
                let id = document.documentID
                let homeName = document.get("home_name") as? String ?? "Unknown"
                let street = document.get("street") as? String ?? "Unknown"
                let city = document.get("city") as? String ?? "Unknown"
                let houseNumber = document.get("house_number") as? String ?? "Unknown"
                let postalCode = document.get("postal_code") as? String ?? "Unknown"
                let userUid = document.get("user_uid") as? String
                let image = document.get("image") as? String

                return Home(
                    id: id,
                    homeName: homeName,
                    street: street,
                    houseNumber: houseNumber,
                    city: city,
                    postalCode: postalCode,
                    userUid: userUid!,
                    image: image
                )
            }
    
        }
    }
    
    func createHome(homeName: String?, city: String?, street: String?, postalCode: String?, houseNumber: String?, fileName: String?) {
        guard let userUID = userUID else { return }
        
        db.collection("homes").addDocument(data: [
            "home_name": homeName as Any,
            "user_uid": userUID,
            "city": city as Any,
            "street": street as Any,
            "postal_code": postalCode as Any,
            "house_number": houseNumber as Any,
            "image": fileName as Any
        ]) { error in
            if let error = error {
                print("Failed to add home to Firestore: \(error)")
            } else {
                print("Home added to Firestore successfully.")
            }
        }
    }

}
