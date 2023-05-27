import SwiftUI

struct ExpandableButtonItem: Identifiable {
  let id = UUID()
  let label: String
  private(set) var action: (() -> Void)? = nil
}

struct ExpandableButtonPanel: View {

  let primaryItem: ExpandableButtonItem
  let secondaryItems: [ExpandableButtonItem]

  private let noop: () -> Void = {}
  private let size: CGFloat = 70
  private var cornerRadius: CGFloat {
    get { size / 2 }
  }
  private let shadowColor = Color.black.opacity(0.4)
  private let shadowPosition: (x: CGFloat, y: CGFloat) = (x: 2, y: 2)
  private let shadowRadius: CGFloat = 3

  @State private var isExpanded = false

  var body: some View {
    VStack {
        if(isExpanded) {
            ForEach(secondaryItems) { item in
                Button(action: item.action ?? self.noop) {
                    Label("", systemImage: item.label)
                        .offset(x: 4, y: 0)
                }
                .frame(
                  width: self.isExpanded ? self.size : 0,
                  height: self.isExpanded ? self.size : 0)
                .foregroundColor(.white)
            }
        }
      

        Button(action: {
            withAnimation {
              self.isExpanded.toggle()
            }
        }) {
            Label("", systemImage: self.isExpanded ? "chevron.down" : "plus")
                .offset(x: 4, y: 0)
        }
        .frame(width: size, height: size)
        .foregroundColor(.white)
    }
    .background(Color(UIColor.systemBlue))
    .cornerRadius(cornerRadius)
    .font(.title)
    .shadow(
      color: shadowColor,
      radius: shadowRadius,
      x: shadowPosition.x,
      y: shadowPosition.y
    )
  }
}
