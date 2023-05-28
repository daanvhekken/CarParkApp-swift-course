//
//  appUser.swift
//  car park
//
//  Created by Daan Vanhekken on 03/11/2022.
//

import Foundation

struct AppUser: Identifiable {
    var id: String
    var defaultHomeId: String?

    
    init(id: String, defaultHomeId: String?){
        self.id = id
        self.defaultHomeId = defaultHomeId
    }
}
