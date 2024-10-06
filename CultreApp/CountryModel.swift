////
////  Model.swift
////  cultureByChatGpt
////
////  Created by Manar Alghmadi on 01/04/1446 AH.
////
//
//import Foundation
//import SwiftData
//
////import SwiftData
//
////@Model
////class Country {
////    var name: String
////    var about: String
////    var culturalTips: [String]
////    var importantPhrases: [String]
////    var mustVisitSpots: [String]
////
////    init(name: String, about: String, culturalTips: [String], importantPhrases: [String], mustVisitSpots: [String]) {
////        self.name = name
////        self.about = about
////        self.culturalTips = culturalTips
////        self.importantPhrases = importantPhrases
////        self.mustVisitSpots = mustVisitSpots
////    }
////}
//
//
////
////  Models.swift
////  CultreApp
////
////  Created by Manar Alghmadi on 27/03/1446 AH.
////
//
//import Foundation
//import SwiftData
//
//
//
//import Foundation
//import SwiftData
//
//@Model
//class Countries: Identifiable, Codable {
//    var counrtryId: Int
//    var counrtryName: String
//    var counrtryImageName: String
//    var counrtryIsFaves: Bool
//
//    // This will serve as the unique identifier for SwiftUI
//    var id: Int {
//        return counrtryId
//    }
//
//    // Initializer
//    init(id: Int, name: String, imageName: String, isFaves: Bool) {
//        self.counrtryId = id
//        self.counrtryName = name
//        self.counrtryImageName = imageName
//        self.counrtryIsFaves = isFaves
//    }
//
//    // Codable conformance
//    enum CodingKeys: String, CodingKey {
//        case counrtryId, counrtryName, counrtryImageName, counrtryIsFaves
//    }
//}
//
//
//
//@Model
//class Catagory: Identifiable {
//    var catagoryId: Int
//    var catagoryName: String
//    
//    init(catagoryId: Int, catagoryName: String) {
//        self.catagoryId = catagoryId
//        self.catagoryName = catagoryName
//    }
//}
//
//
//
//@Model
//class CatagoryContent: Identifiable {
//    var catagoryContentId: Int
//       var counrtryId: Int
//       var catagoryId: Int
//       var content: String
//       var imageName: String?  // Optional image for the category content
//
//       init(catagoryContentId: Int, counrtryId: Int, catagoryId: Int, content: String, imageName: String? = nil) {
//           self.catagoryContentId = catagoryContentId
//           self.counrtryId = counrtryId
//           self.catagoryId = catagoryId
//           self.content = content
//           self.imageName = imageName  // Add image here to style category content
//       }
//}
//
//
//
//
//
//




import Foundation
import SwiftData

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
