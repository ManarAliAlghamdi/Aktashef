

import Foundation
import SwiftData
import SwiftUI

@Model
class Countries: Identifiable, Codable {  // Conforms to Codable
    var counrtryId: Int
    var counrtryName: String
    var counrtryImageName: String
    var counrtryIsFaves: Bool

    // This will serve as the unique identifier for SwiftUI
    var id: Int {
        return counrtryId
    }

    // Initializer
    init(id: Int, name: String, imageName: String, isFaves: Bool) {
        self.counrtryId = id
        self.counrtryName = name
        self.counrtryImageName = imageName
        self.counrtryIsFaves = isFaves
    }

    // Codable conformance (Encodable and Decodable)
    enum CodingKeys: String, CodingKey {
        case counrtryId, counrtryName, counrtryImageName, counrtryIsFaves
    }

    // Custom encoding (optional, handled automatically in most cases)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(counrtryId, forKey: .counrtryId)
        try container.encode(counrtryName, forKey: .counrtryName)
        try container.encode(counrtryImageName, forKey: .counrtryImageName)
        try container.encode(counrtryIsFaves, forKey: .counrtryIsFaves)
    }

    // Custom decoding (optional, handled automatically in most cases)
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.counrtryId = try container.decode(Int.self, forKey: .counrtryId)
        self.counrtryName = try container.decode(String.self, forKey: .counrtryName)
        self.counrtryImageName = try container.decode(String.self, forKey: .counrtryImageName)
        self.counrtryIsFaves = try container.decode(Bool.self, forKey: .counrtryIsFaves)
    }
}



struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            HStack {
                TextField("على وين رايح؟ ...", text: $text)
                    .multilineTextAlignment(.trailing) // Align text to the right
                    .padding(7)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, alignment: .trailing) // Ensure the entire HStack aligns to the right
        }
    }
}


struct Category: Identifiable, Codable {
    let id = UUID()
    let catagoryId: Int
    let catagoryName: String
}

struct CategoryContent: Identifiable, Codable {
    let id = UUID()
    let catagoryId: Int
    let counrtryId: Int
    let content: String
}


