//
//  BlankView.swift
//  Devote
//
//  Created by Quest76 on 06.12.2023.
//

import SwiftUI

struct BlankView: View {
  var backgroundColor: Color
  var backgroundOpacity: Double
  
  var body: some View {
    VStack {
      Spacer()
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    .background(backgroundColor)
    .opacity(backgroundOpacity)
    .blendMode(.overlay)
    .edgesIgnoringSafeArea(.all)
  }
}

#Preview {
  BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
    .background(BackgroundImageView())
    .background(backgroundGradient.ignoresSafeArea(.all))
}
