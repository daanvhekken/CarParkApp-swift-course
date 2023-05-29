import Foundation

struct AppUser: Identifiable {
    var id: String
    var defaultHomeId: String?

    
    init(id: String, defaultHomeId: String?){
        self.id = id
        self.defaultHomeId = defaultHomeId
    }
}
