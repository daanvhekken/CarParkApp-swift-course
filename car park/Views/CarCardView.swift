import SwiftUI

struct CarCardView: View {
    var car: Car

    @State private var isAnimating: Bool = false

    @StateObject private var loader: ImageLoaderTest
    
    var carTitle: String

    init(car: Car) {
        self.car = car
        let imagePath = car.image ?? "default_image_path.jpg"
        _loader = StateObject(wrappedValue: ImageLoaderTest(imagePath: imagePath))
                
        var title = car.brand + " " + car.model + " "
        if car.variant != nil {
            title += car.variant ?? ""
        }
        carTitle = title
    }
  
    var body: some View {
        ZStack {
            VStack() {
                if loader.imageURL != nil {
                    AsyncImage2(url: loader.imageURL!)
                } else {
                    Image(systemName: "house.circle.fill").iconModifier()
                }
                    
                // CAR: TITLE
                Text(carTitle)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)

                // CAR: HEADLINE
                Text(car.color)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                
                NavigationLink {
                  CarDetailView(car: car)
                        .navigationBarHidden(true)
                } label: {
                  HStack(spacing: 8) {
                      Text("View")
                      Image(systemName: "arrow.right.circle")
                        .imageScale(.large)
                  }
                  .padding(.horizontal, 16)
                  .padding(.vertical, 10)
                  .background(
                    Capsule().strokeBorder(Color.white, lineWidth: 1.25)
                  )
                }
                .accentColor(Color.white)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
            if car.image != nil {
                loader.loadImage()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}
