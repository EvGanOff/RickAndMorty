//
//  Model.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import Foundation
import UIKit

struct Results: Codable, Hashable{
    var results: [Characters]
}

struct Characters: Codable, Hashable {
    let name: String
    var status: String?
    let species: String
    let gender: String
    var image: String?
    var episode: [String]
}

//struct Location: Codable, Hashable {
//    var name: String
//}
