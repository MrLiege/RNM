//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 11.01.2025.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var viewModel: CharacterViewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            CharacterTableView(viewModel: viewModel)
                .navigationTitle("Character")
        }
    }
}
