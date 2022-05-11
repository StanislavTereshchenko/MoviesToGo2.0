//
//  Movies.swift
//  Movies6.0
//
//  Created by Stanislav Tereshchenko on 29.04.2022.
//

import Foundation
import UIKit

enum Rating {
    case spider
    case batman
    case superman
    case vikings
    case joker
    
    var rating: String {
        switch self {
        case .spider:
            return "9.2"
        case .batman:
            return "7.4"
        case .superman:
            return "5.2"
        case .vikings:
            return "8.2"
        case .joker:
            return "9.7"
        }
    }
}
struct ResultMovie: Codable {
    var results: [Movies]
}
struct Movies : Codable {
    var title: String
    var poster_path: String
    var overview: String
    var backdrop_path: String
    var release_date: String
    var popularity: Double

}
