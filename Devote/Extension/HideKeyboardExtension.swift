//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Quest76 on 06.12.2023.
//

import SwiftUI

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
