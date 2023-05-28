import Foundation

struct Model: Identifiable {
    var id: String
    var makeId: Int
    var modelId: Int
    var makeName: String
    var modelName: String

    init(id: String, makeId: Int, modelId: Int, makeName: String, modelName: String){
        self.id = id
        self.makeId = makeId
        self.modelId = modelId
        self.makeName = makeName
        self.modelName = modelName
    }
}
