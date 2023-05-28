//
//  ImageLoaderTest.swift
//  car park
//
//  Created by Daan Vanhekken on 28/05/2023.
//

import SwiftUI

import FirebaseStorage

class ImageLoaderTest: ObservableObject {
    @Published var imageURL: URL?
    
    private let storage = Storage.storage()
    private let imagePath: String
    private lazy var storageRef = self.storage.reference()
    private lazy var imageRef = self.storageRef.child(imagePath)

    init(imagePath: String) {
        self.imagePath = imagePath
    }

    func loadImage() {
        self.imageRef.downloadURL { url, error in
            if let error = error {
                print("Error getting download URL: \(error)")
            } else {
                if let url = url {
                    DispatchQueue.main.async {
                        self.imageURL = url
                    }
                }
            }
        }
    }
}
