//
//  Alert.swift
//  RickAndMorty
//
//  Created by Artyom Petrichenko on 12.01.2025.
//

import SwiftEntryKit
import SwiftUI

func showErrorAlert(message: String) {
    var attributes = EKAttributes.topToast
    attributes.entryBackground = .color(color: .init(light: .red, dark: .red))
    attributes.entranceAnimation = .init(translate: .init(duration: 0.3, anchorPosition: .top, spring: .init(damping: 1, initialVelocity: 0)))
    attributes.exitAnimation = .init(translate: .init(duration: 0.3, anchorPosition: .top, spring: .init(damping: 1, initialVelocity: 0)))
    attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3)))
    attributes.displayDuration = 2
    
    let title = EKProperty.LabelContent(text: "Error", style: .init(font: .boldSystemFont(ofSize: 16), color: .white))
    let description = EKProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 14), color: .white))
    let simpleMessage = EKSimpleMessage(title: title, description: description)
    let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
    let contentView = EKNotificationMessageView(with: notificationMessage)
    
    SwiftEntryKit.display(entry: contentView, using: attributes)
}
