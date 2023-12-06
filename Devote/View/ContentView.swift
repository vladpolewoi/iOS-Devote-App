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

  @State var task: String = ""

  private var isButtonDisabled: Bool {
    task.isEmpty
  }

  // MARK: - Fetch

  @Environment(\.managedObjectContext) private var viewContext
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default
  )
  private var items: FetchedResults<Item>

  // MARK: - func

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
    }
  }

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
      VStack {
        VStack(spacing: 16) {
          TextField("New Task", text: $task)
            .padding()
            .background(
              Color(UIColor.systemGray6)
            )
            .cornerRadius(10)

          Button {
            addItem()
          } label: {
            Spacer()
            Text("Save")
            Spacer()
          }
          .disabled(isButtonDisabled)
          .padding()
          .font(.headline)
          .foregroundStyle(.white)
          .background(isButtonDisabled ? .gray : .pink)
          .cornerRadius(25)
        }
        .padding()

        List {
          ForEach(items) { item in
            NavigationLink {
              Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            } label: {
              VStack(alignment: .leading) {
                Text(item.task ?? "")
                  .font(.headline)
                  .fontWeight(.bold)
                Text(item.timestamp!, formatter: itemFormatter)
                  .font(.footnote)
                  .foregroundStyle(.gray)
              }
            }
          }
          .onDelete(perform: deleteItems)
        }
      }
      .navigationTitle(Text("Daily Task"))
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
      }
      Text("Select an item")
    }
  }
}

#Preview {
  ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
