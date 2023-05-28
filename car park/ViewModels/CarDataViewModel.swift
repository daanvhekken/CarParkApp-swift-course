import Foundation
import FirebaseFirestore
import FirebaseAuth

class CarDataViewModel: ObservableObject {
    @Published var makes = [Make]()
    @Published var models = [Model]()
    
    @Published var defaultHomeId = "none"
    private var db = Firestore.firestore()
    
    let userUID = Auth.auth().currentUser?.uid
    
    func fetchMakes() {
        db.collection("makes").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            
            
            self.makes = documents.compactMap { document in
                let id = document.documentID
                let makeId = document.get("MakeId") as! Int
                let makeName = document.get("MakeName") as! String

                return Make(
                    id: id,
                    makeId: makeId,
                    makeName: makeName
                )
            }
        }
    }
    
    func fetchModels(makeId: Int) {
        db.collection("models").whereField("Make_ID", isEqualTo: makeId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.models = documents.compactMap { document in
                let id = document.documentID
                let makeId = document.get("Make_ID") as! Int
                let makeName = document.get("Make_Name") as! String
                let modelId = document.get("Model_ID") as! Int
                let modelName = document.get("Model_Name") as! String

                return Model(
                    id: id,
                    makeId: makeId,
                    modelId: modelId,
                    makeName: makeName,
                    modelName: modelName
                )
            }
        }
    }
}
