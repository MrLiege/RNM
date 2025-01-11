//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 11.01.2025.
//

import SwiftUI
import NukeUI

struct CharacterCellView: View {
    let character: Character
    
    var body: some View {
        HStack {
            characterImage
            characterVStack
            
            Spacer()
        }
    }
}

// MARK: - Character's image
private extension CharacterCellView {
    @ViewBuilder
    var characterImage: some View {
        if let imageUrlString = character.image,
           let imageUrl = URL(string: imageUrlString) {
            LazyImage(url: imageUrl) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                } else {
                    Color.gray
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .overlay(ProgressView().progressViewStyle(CircularProgressViewStyle()))
                }
            }
            .padding()
            .frame(width: 120, height: 120)
        } else {
            Color.gray
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding()
        }
        
    }
}

// MARK: - VStack with info character
private extension CharacterCellView {
    @ViewBuilder
    var characterVStack: some View {
        Spacer()
        
        VStack(alignment: .leading) {
            if let name = character.name {
                HStack {
                    Text(name)
                        .mediumText()
                    Spacer()
                    statusButton
                }
            }
            
            if let gender = character.gender?.lowercased(),
                let species = character.species {
                Text("\(species), \(gender)")
                    .regularText()
            }
            
            Button {
                print("Button episode")
            } label: {
                HStack {
                    Image(systemName: "arrowtriangle.forward.fill")
                        .frame(height: 12)
                        .foregroundColor(.orangeRNMColor)
                    Text("Watch episodes")
                        .regularText()
                        .foregroundColor(.orangeRNMColor)
                }
            }
            .buttonStyle(OrangeRNMButtonStyle())
            
            imageWithText
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var imageWithText: some View {
        HStack(spacing: 8) {
            Image("point")
                .frame(width: 12, height: 12)
            
            if let originName = character.origin.name {
                Text(originName)
                    .regularText()
                    .foregroundColor(.grayDarkRNMColor)
            }
        }
    }
}


// MARK: - View with Characture's status which have other colors
private extension CharacterCellView {
    @ViewBuilder
    var statusButton: some View {
        if let status = character.status?.uppercased() {
            Text(status)
                .mediumText(size: 14)
                .padding(.horizontal, 8)
                .frame(height: 25)
                .background(statusBackgroundColor(for: status))
                .foregroundColor(statusTextColor(for: status))
                .cornerRadius(25)
        }
    }

    // MARK: identify the color
    private func statusBackgroundColor(for status: String) -> Color {
        switch status {
        case "ALIVE":
            return .greenLightRNMColor
        case "DEAD":
            return .redLightRNMColor
        case "UNKNOWN":
            return .grayLightRNMColor
        default:
            return .grayLightRNMColor
        }
    }

    private func statusTextColor(for status: String) -> Color {
        switch status {
        case "ALIVE":
            return .greenDarkRNMColor
        case "DEAD":
            return .redRNMColor
        case "UNKNOWN":
            return .grayRNMColor
        default:
            return .grayRNMColor
        }
    }
}
