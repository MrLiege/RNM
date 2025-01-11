//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 11.01.2025.
//

import Foundation
import Combine
import SwiftEntryKit

final class CharacterViewModel: ObservableObject {
    let input: Input
    @Published var output: Output
    
    private var cancellables = Set<AnyCancellable>()
    private let characterService: CharacterAPIServiceProtocol
    
    init(characterService: CharacterAPIServiceProtocol = CharacterAPIService()) {
        self.input = Input()
        self.output = Output()
        self.characterService = characterService
        
        bind()
    }
}

private extension CharacterViewModel {
    func bind() {
        input.onAppear
            .sink { [weak self] in
                self?.getCharacters()
            }
            .store(in: &cancellables)
        
        input.loadNextPage
            .sink { [weak self] in
                self?.loadNextPage()
            }
            .store(in: &cancellables)
    }
    
    func getCharacters(page: Int = 1) {
        guard !output.isLastPage else { return }
        
        output.isLoadingPage = true
        
        characterService.getAllCharacters(page: page)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("\(error)")
                        showErrorAlert(message: "\(error.localizedDescription)")
                    }
                    self.output.isLoadingPage = false
                },
                receiveValue: { [weak self] response in
                    self?.output.currentPage = page
                    self?.output.isLastPage = response.info.next == nil
                    self?.output.characters += response.results
                    self?.output.isLoadingPage = false
                }
            )
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
        getCharacters(page: output.currentPage + 1)
    }
}

extension CharacterViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let loadNextPage = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var characters: [Character] = []
        var currentPage = 1
        var isLastPage = false
        var isLoadingPage = false
    }
}
