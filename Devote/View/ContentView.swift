//
//  ContentView.swift
//  test
//
//  Created by Quest76 on 06.12.2023.
//

import CoreData
import SwiftUI

struct ContentView: View {
  // MARK: - Props

  @AppStorage("isDarkMode") private var isDarkMode: Bool = false
  @State var task: String = ""
  @State private var showNewTaskItem: Bool = false

  // MARK: - Fetch

  @Environment(\.managedObjectContext) private var viewContext
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default
  )
  private var items: FetchedResults<Item>

  // MARK: - func

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)

      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

  // MARK: - Body

  var body: some View {
    NavigationView {
      ZStack {
        // MARK: - Main View

        VStack {
          // MARK: - Header

          HStack(spacing: 10) {
            Text("Devote")
              .font(.system(.largeTitle, design: .rounded))
              .fontWeight(.heavy)
              .padding(.leading, 4)

            Spacer()

            EditButton()
              .font(.system(size: 16, weight: .semibold, design: .rounded))
              .padding(.horizontal, 10)
              .frame(minWidth: 70, minHeight: 24)
              .background(Capsule().stroke(.white, lineWidth: 2))

            Button {
              isDarkMode.toggle()
              playSound(sound: "sound-tap", type: "mp3")
              feedback.notificationOccurred(.success)
            } label: {
              Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .font(.system(.title, design: .rounded))
                .contentTransition(.symbolEffect(.replace.downUp))
            }
          }
          .padding()
          .foregroundStyle(.white)
          Spacer(minLength: 80)

          // MARK: - New Task Button

          Button {
            showNewTaskItem = true
            playSound(sound: "sound-ding", type: "mp3")
            feedback.notificationOccurred(.success)
          } label: {
            Image(systemName: "plus.circle")
              .font(.system(size: 30, weight: .bold, design: .rounded))
            Text("New Task")
              .font(.system(size: 24, weight: .bold, design: .rounded))
          }
          .foregroundStyle(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 15)
          .background(
            LinearGradient(
              gradient: Gradient(colors: [.pink, .blue]),
              startPoint: .leading,
              endPoint: .trailing
            )
            .clipShape(Capsule())
          )
          .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)

          // MARK: - Tasks

          List {
            ForEach(items) { item in
              ListRowItemView(item: item)
            }
            .onDelete(perform: deleteItems)
          }
          .scrollContentBackground(.hidden)
          .listStyle(InsetGroupedListStyle())
          .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
          .padding(.vertical, 0)
          .frame(maxWidth: 640)
        }
        .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
        .transition(.move(edge: .bottom))
        .animation(.easeOut(duration: 0.5), value: showNewTaskItem)

        // MARK: - New Task Item

        if showNewTaskItem {
          BlankView(
            backgroundColor: isDarkMode ? .black : .gray,
            backgroundOpacity: isDarkMode ? 0.3 : 0.5
          )
          .onTapGesture {
            withAnimation {
              showNewTaskItem = false
            }
          }

          NewTaskItemView(isShowing: $showNewTaskItem)
        }
      }
      .navigationBarTitle("Daily Tasks", displayMode: .large)
      .navigationBarHidden(true)
      .background(
        BackgroundImageView()
          .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
      )
      .background(backgroundGradient.ignoresSafeArea(.all))
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

#Preview {
  ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
