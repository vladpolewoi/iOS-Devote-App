//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Quest76 on 06.12.2023.
//

import SwiftUI

struct NewTaskItemView: View {
  // MARK: - Props

  @AppStorage("isDarkMode") private var isDarkMode: Bool = false
  @Environment(\.managedObjectContext) private var viewContext
  @State var task: String = ""
  @Binding var isShowing: Bool

  private var isButtonDisabled: Bool {
    task.isEmpty
  }

  // MARK: - Functions

  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = task
      newItem.completion = false
      newItem.id = UUID()

      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }

      task = ""
      hideKeyboard()
      isShowing = false
    }
  }

  var body: some View {
    VStack {
      Spacer()

      VStack(spacing: 16) {
        TextField("New Task", text: $task)
          .foregroundStyle(.pink)
          .font(.system(size: 24, weight: .bold, design: .rounded))
          .padding()
          .background(
            isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.systemGray6)
          )
          .cornerRadius(10)

        Button {
          addItem()
          playSound(sound: "sound-ding", type: "mp3")
          feedback.notificationOccurred(.success)
        } label: {
          Spacer()
          Text("Save")
            .font(.system(size: 24, weight: .bold, design: .rounded))
          Spacer()
        }
        .disabled(isButtonDisabled)
        .onTapGesture {
          if isButtonDisabled {
            playSound(sound: "sound-tap", type: "mp3")
          }
        }
        .padding()
        .font(.headline)
        .foregroundStyle(.white)
        .background(isButtonDisabled ? .blue : .pink)
        .cornerRadius(25)
      }
      .padding(.horizontal)
      .padding(.vertical, 20)
      .background(isDarkMode ? Color(UIColor.secondarySystemBackground) : .white)
      .cornerRadius(25)
      .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 25)
      .frame(maxWidth: 640)
    }
    .padding()
  }
}

#Preview {
  NewTaskItemView(isShowing: .constant(true))
    .background(.gray)
}
