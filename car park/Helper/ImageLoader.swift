import SwiftUI
import Combine

extension Image {
  func imageModifier() -> some View {
    self
      .resizable()
      .scaledToFit()
      .frame(width: 62, height: 42)
      .aspectRatio(contentMode: .fit)
  }
  
  func iconModifier() -> some View {
    self
      .imageModifier()
      .frame(width: 62, height: 32)
      .foregroundColor(Color(.systemBlue))
      .opacity(0.5)
  }
}

class ImageLoader: ObservableObject {
    @Published var imageData: Data = Data()
    private let url: URL
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancellable?.cancel()
    }

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: Data())
            .receive(on: DispatchQueue.main)
            .assign(to: \.imageData, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader

    init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }

    private var image: some View {
        Group {
            if loader.imageData.isEmpty {
                Image(systemName: "house.circle.fill").iconModifier()
            } else {
                Image(uiImage: UIImage(data: loader.imageData)!).imageModifier()
            }
        }
    }
}
