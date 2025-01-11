//
//  CharacterEndpointt.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 10.01.2025.
//

import Moya
import Foundation

enum CharacterEndpoint {
    case getCharacters(page: Int)
}

extension CharacterEndpoint: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else {
            fatalError("Incorrect \(self) baseURL!")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCharacters(let page):
            return .requestParameters(parameters: ["page" : page], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
