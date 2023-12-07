//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Quest76 on 06.12.2023.
//

import SwiftUI

struct BackgroundImageView: View {
  var body: some View {
    Image("rocket")
      .antialiased(true)
      .resizable()
      .scaledToFill()
      .ignoresSafeArea(.all)
  }
}

#Preview {
  BackgroundImageView()
}
