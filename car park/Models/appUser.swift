//
//  appUser.swift
//  car park
//
//  Created by Daan Vanhekken on 03/11/2022.
//

import Foundation

struct AppUser: Identifiable {
    var id: String
    var defaultHomeName: String

    
    init(id: String, defaultHomeName: String){
        self.id = id
        self.defaultHomeName = defaultHomeName
    }
}
