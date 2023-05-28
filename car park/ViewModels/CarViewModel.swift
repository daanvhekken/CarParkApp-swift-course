import Foundation
import FirebaseFirestore
import FirebaseAuth

class CarViewModel: ObservableObject {
    @Published var cars = [Car]()
    @Published var allUserCars = [Car]()
    
    @Published var defaultHomeId = "none"
    private var db = Firestore.firestore()
    
    let userUID = Auth.auth().currentUser?.uid
    
    func fetchData() {
        guard let userUID = userUID else { return }

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
                self.defaultHomeId = document.get("default_home_id") as? String ?? "none"
            }
            self.fetchCars()
        }
    }
    
    func fetchCars() {
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
                let brand = document.get("brand") as! String
                let color = document.get("color") as! String
                let homeId = document.get("home_id") as! String
                let model = document.get("model") as! String
                let variant = document.get("variant") as? String ?? "Unknown"
                let year = document.get("year") as! Int
                let userUid = document.get("user_uid") as! String
                let image = document.get("image") as? String

                return Car(
                    id: id,
                    brand: brand,
                    homeId: homeId,
                    model: model,
                    variant: variant,
                    year: year,
                    color: color,
                    userUid: userUid,
                    image: image
                )
            }
            
            self.cars = self.allUserCars.filter({ car in
                car.homeId == self.defaultHomeId
            })
        }
    }
    
    func createCar(brand: String, model: String, variant: String?, year: Int, color: String, fileName: String?) {
        guard let userUID = userUID else { return }
        
        db.collection("cars").addDocument(data: [
            "user_uid": userUID,
            "home_id": self.defaultHomeId,
            "brand": brand as String,
            "model": model as String,
            "variant": variant as String? ?? "unknown",
            "year": year as Int,
            "color": color as String,
            "image": fileName as String? ?? "none"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.fetchData()
            }
        }
    }
}
