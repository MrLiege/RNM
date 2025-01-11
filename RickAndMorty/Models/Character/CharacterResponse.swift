//
//  CharacterResponse.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 11.01.2025.
//

import Foundation

struct CharacterResponse: Codable {
    struct Info: Codable {
        let next: String?
    }
    let info: Info
    let results: [Character]
}
