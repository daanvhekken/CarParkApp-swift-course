import Foundation

struct Make: Identifiable {
    var id: String
    var makeId: Int
    var makeName: String

    
    init(id: String, makeId: Int, makeName: String){
        self.id = id
        self.makeId = makeId
        self.makeName = makeName
    }
}
