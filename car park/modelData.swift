// ModelData.swift

import Foundation

var carBrandData: [CarBrand] = load("data.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    do {
        data = try Data (contentsOf: file)
    } catch {
        fatalError ("Couldn't load \(filename)")
    }
    do {
        let decoder = JSONDecoder ()
        return try decoder.decode (T.self, from: data)
    } catch {
        fatalError("")
    }
}
