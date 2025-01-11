//
//  CharacterAPI.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 10.01.2025.
//

import Moya
import Combine
import Foundation
import CombineExt
import CombineMoya

protocol CharacterAPIServiceProtocol {
    func getAllCharacters(page: Int) -> AnyPublisher<CharacterResponse, MoyaError>
}

final class CharacterAPIService {
    let provider = MoyaProvider<CharacterEndpoint>(plugins: [NetworkLoggerPlugin()])
}

extension CharacterAPIService: CharacterAPIServiceProtocol {
    func getAllCharacters(page: Int) -> AnyPublisher<CharacterResponse, MoyaError> {
        return provider.requestPublisher(.getCharacters(page: page))
            .map(\.data)
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .mapError { error in
                return error as? MoyaError ?? MoyaError.underlying(error, nil)
            }
            .eraseToAnyPublisher()
    }
}
