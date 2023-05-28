import SwiftUI


struct HomeRowView: View {
    @ObservedObject private var authViewModel = AuthViewModel()

    var isDefault: Bool
    var home: Home

    @StateObject private var loader: ImageLoaderTest
    
    init(home: Home, isDefault: Bool) {
        self.home = home
        let imagePath = home.image ?? "default_image_path.jpg"
        _loader = StateObject(wrappedValue: ImageLoaderTest(imagePath: imagePath))
        self.isDefault = isDefault
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
            
            Spacer()
            
            if isDefault {
                HStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
        }.onAppear {
            if home.image != nil {
                loader.loadImage()
            }
        }
    }
}
