//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
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

struct HomeRowView: View {
    var home: Home
    
    @StateObject private var loader: ImageLoaderTest

    init(home: Home) {
        self.home = home
        let imagePath = home.image ?? "default_image_path.jpg"
        _loader = StateObject(wrappedValue: ImageLoaderTest(imagePath: imagePath))
    }


    var body: some View {
        HStack {
            if loader.imageURL != nil {
                AsyncImage(url: loader.imageURL!)
            } else {
                Image(systemName: "house.circle.fill").iconModifier()
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(home.homeName)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(home.street)
                    .font(.caption)
                    .foregroundColor(Color.secondary)
            }
        }.onAppear {
            if home.image != nil {
                loader.loadImage()
            }
        }
    }
}
