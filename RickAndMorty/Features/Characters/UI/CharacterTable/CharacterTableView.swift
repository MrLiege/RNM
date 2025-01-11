//
//  CharacterTableView.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 12.01.2025.
//

import SwiftUI

struct CharacterTableView: View {
    @ObservedObject var viewModel: CharacterViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.output.characters) { character in
                    CharacterCellView(character: character)
                        .onAppear {
                            if character == viewModel.output.characters.last {
                                viewModel.input.loadNextPage.send()
                            }
                        }
                }
                .padding()
                if viewModel.output.isLoadingPage {
                    ProgressView()
                        .padding()
                }
            }
        }
        .onAppear { viewModel.input.onAppear.send() }
    }
}
