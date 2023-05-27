import Foundation
import FirebaseFirestore
import FirebaseAuth

class CarViewModel: ObservableObject {
    
    @Published var cars = [Car]()
    @Published var allUserCars = [Car]()
    @Published var addCarSheet: Bool = false
        
    private var db = Firestore.firestore()
    
    let userUID = Auth.auth().currentUser?.uid
    
    func fetchData() {
        guard let userUID = userUID else { return }
        
        var defaultHomeName = "none"
        
        db.collection("users").whereField("uid", isEqualTo: userUID).getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            documents.forEach { document in
                defaultHomeName = document.get("default_home_name") as? String ?? "none"
            }
            self.fetchCars(defaultHomeName: defaultHomeName)
        }
    }
    
    func fetchCars(defaultHomeName: String) {
        guard let userUID = userUID else { return }

        db.collection("cars").whereField("user_uid", isEqualTo: userUID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.allUserCars = documents.compactMap { document in
                let id = document.documentID
                let brand = document.get("brand") as? String ?? "Unknown"
                let color = document.get("color") as? String ?? "Unknown"
                let homeName = document.get("home_name") as? String ?? "unknown"
                let model = document.get("model") as? String ?? "Unknown"
                let variant = document.get("variant") as? String ?? "Unknown"
                let year = document.get("year") as? Int ?? 0
                let userUid = document.get("user_uid") as? String
                let image = document.get("image") as? String ?? "none"

                return Car(
                    id: id,
                    brand: brand,
                    homeName: homeName,
                    model: model,
                    variant: variant,
                    year: year,
                    color: color,
                    userUid: userUid!,
                    image: image
                )
            }
            
            self.cars = self.allUserCars.filter({ car in
                car.homeName == defaultHomeName
            })
        }
    }
}
