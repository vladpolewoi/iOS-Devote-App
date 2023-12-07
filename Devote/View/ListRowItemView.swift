//
//  ListRowItemView.swift
//  Devote
//
//  Created by Quest76 on 07.12.2023.
//

import SwiftUI

struct ListRowItemView: View {
  @Environment(\.managedObjectContext) var viewContext
  @ObservedObject var item: Item

  var body: some View {
    Toggle(isOn: $item.completion) {
      Text(item.task ?? "")
        .font(.system(.title2, design: .rounded))
        .fontWeight(.heavy)
        .foregroundStyle(item.completion ? .pink : .primary)
        .padding(.vertical, 12)
        .animation(.easeInOut(duration: 0.1), value: item.completion)
    }
    .toggleStyle(CheckboxStyle())
    .onReceive(item.objectWillChange, perform: { _ in
      if self.viewContext.hasChanges {
        try? self.viewContext.save()
      }
    })
  }
}

// #Preview {
//  ListRowItemView()
// }
