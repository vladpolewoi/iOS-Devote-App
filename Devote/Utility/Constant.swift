//
//  Constant.swift
//  Devote
//
//  Created by Quest76 on 06.12.2023.
//

import SwiftUI

// MARK: - Formatter

let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

// MARK: - UI

var backgroundGradient: LinearGradient {
  return LinearGradient(
    gradient: Gradient(colors: [Color.pink, Color.blue]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing
  )
}

// MARK: - UX

let feedback = UINotificationFeedbackGenerator()
