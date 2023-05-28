import Foundation

struct Car: Identifiable {
    var id: String
    var brand: String
    var homeId: String
    var model: String
    var variant: String?
    var year: Int
    var color: String
    var userUid: String
    var image: String? // path to image (URL)
    
    init(id: String, brand: String, homeId: String, model: String, variant: String?, year: Int, color: String, userUid: String, image: String?){
        self.id = id
        self.brand = brand
        self.homeId = homeId
        self.model = model
        self.variant = variant
        self.year = year
        self.color = color
        self.userUid = userUid
        self.image = image
    }
}
