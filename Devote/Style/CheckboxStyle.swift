//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Quest76 on 07.12.2023.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
        .foregroundStyle(configuration.isOn ? .pink : .primary)
        .font(.system(size: 30, weight: .semibold, design: .rounded))
        .onTapGesture {
          configuration.isOn.toggle()

          if configuration.isOn {
            playSound(sound: "sound-rise", type: "mp3")
          } else {
            playSound(sound: "sound-tap", type: "mp3")
          }

          feedback.notificationOccurred(.success)
        }

      configuration.label
    }
  }
}

#Preview {
  Toggle("Placeholder lae", isOn: .constant(true))
    .toggleStyle(CheckboxStyle())
    .padding()
    .previewLayout(.sizeThatFits)
}
