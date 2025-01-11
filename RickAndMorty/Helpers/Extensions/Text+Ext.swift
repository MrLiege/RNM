//
//  Ext+Text.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 12.01.2025.
//

import SwiftUI

extension Text {
    func mediumText(size: CGFloat = 21) -> some View {
        self.font(.system(size: size, weight: .medium))
    }
    
    func regularText() -> some View {
        self.font(.system(size: 14, weight: .regular))
    }
}
