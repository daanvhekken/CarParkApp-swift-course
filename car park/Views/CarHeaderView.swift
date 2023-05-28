import SwiftUI

struct CarHeaderView: View {
    var car: Car

    @State private var isAnimatingImage: Bool = false
    @StateObject private var loader: ImageLoaderTest

    init(car: Car) {
        self.car = car
        let imagePath = car.image ?? "default_image_path.jpg"
        _loader = StateObject(wrappedValue: ImageLoaderTest(imagePath: imagePath))
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            if loader.imageURL != nil {
                AsyncImage2(url: loader.imageURL!)
            } else {
                Image(systemName: "house.circle.fill").iconModifier()
            }
        }
        .frame(height: 440)
        .onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimatingImage = true
            }
            if car.image != nil {
                loader.loadImage()
            }
        }
    }
}
