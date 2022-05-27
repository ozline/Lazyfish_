//
//  ContentView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var username:String = ""
    @State private var password:String = ""

    var body: some View {
        TabView{
            NavigationView {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            Text(item.timestamp!, formatter: itemFormatter)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("Lazyfish")
                Text("Select an item")
            }
            .tabItem({
                Image(systemName: "house")
                Text("首页")
            })
            
            NavigationView{
                Form{
                    Section(header: Text("账号")){
                        TextField("账号",text: $username)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.leading)
//                            .padding(.horizontal,26)
                            .keyboardType(.phonePad)
                    }
                    Section(header: Text("密码")){
                        SecureField("密码",text:$password)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.leading)
//                            .padding(.horizontal,26)
                            .keyboardType(.phonePad)
                    }
                    Button(action:addItem){
                        HStack{
                            Spacer()
                            Text("登录")
                            Spacer()
                        }
                    }
                }
                    
                    .navigationTitle("Login")
            }
            .tabItem({
                    Image(systemName: "gear")
                    Text("Login")
                })
            
            Text("PAGE THREE")
                .tabItem({
                    Image(systemName: "person")
                    Text("我的")
                })
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
        }
    }
}
