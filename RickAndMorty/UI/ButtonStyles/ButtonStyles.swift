//
//  ButtonStyles.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 12.01.2025.
//

import SwiftUI

struct OrangeRNMButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(height: 35)
            .background(Color.orangeRNMColor.opacity(0.1))
            .foregroundColor(.orangeRNMColor)
            .cornerRadius(17)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
