//
//  home.swift
//  car park
//
//  Created by Daan Vanhekken on 03/11/2022.
//

import Foundation

struct Home: Identifiable {
    var id: String
    var homeName: String
    var street: String
    var houseNumber: String
    var city: String
    var postalCode: String
    var userUid: String
    var image: String? // path to image (URL)
    
    init(id: String, homeName: String, street: String, houseNumber: String, city: String, postalCode: String, userUid: String, image: String?){
        self.id = id
        self.homeName = homeName
        self.street = street
        self.city = city
        self.houseNumber = houseNumber
        self.postalCode = postalCode
        self.userUid = userUid
        self.image = image
    }
}
