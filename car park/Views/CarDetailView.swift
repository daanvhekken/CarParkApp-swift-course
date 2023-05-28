import SwiftUI

struct CarDetailView: View {
    var car: Car
    
    var carTitle: String
    
    init(car: Car) {
        self.car = car
        
        var title = car.brand + " " + car.model + " "
        if car.variant != nil {
            title += car.variant ?? ""
        }
        carTitle = title
    }
    
    @Environment(\.presentationMode) var presentationMode

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .center, spacing: 20) {
          // HEADER
          CarHeaderView(car: car)
          
          VStack(alignment: .leading, spacing: 20) {
              HStack {
                  Text(carTitle)
                  .font(.largeTitle)
                  .fontWeight(.heavy)
                  .foregroundColor(Color.blue)
              }
              
            
            // HEADLINE
              Text(car.color)
              .font(.headline)
              .multilineTextAlignment(.leading)
            
            // NUTRIENTS
//            FruitNutrientsView(fruit: fruit)
            
            // SUBHEADLINE
            Text("Add more info to".uppercased())
              .fontWeight(.bold)
              .foregroundColor(Color.blue)
            
            // DESCRIPTION
//            Text(fruit.description)
//              .multilineTextAlignment(.leading)
            
            // LINK
//            SourceLinkView()
//              .padding(.top, 10)
//              .padding(.bottom, 40)
          } //: VSTACK
          .padding(.horizontal, 20)
          .frame(maxWidth: 640, alignment: .center)
        } //: VSTACK
        .navigationBarTitle(carTitle, displayMode: .inline)
        .navigationBarItems(leading: backButton)
      } //: SCROLL
//      .edgesIgnoringSafeArea(.top)
    } //: NAVIGATION
    .navigationViewStyle(StackNavigationViewStyle())
  }
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // Dismiss the view
        }) {
        Image(systemName: "chevron.left")
            .imageScale(.large)
            .padding()
        }
    }
}
