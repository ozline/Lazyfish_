//
//  ContentView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let persistenceController = PersistenceController.shared
    
    @State private var username:String = ""
    @State private var password:String = ""
    @State private var loginActive:Bool = false
    @State private var selection:Int = 0
    
    var handler: Binding<Int>{
        Binding(
            get: { self.selection }, set:{
                self.selection = $0
                if(self.selection==2){
                    if(!isLogin){
                        self.loginActive.toggle()
                    }
                }
            }
        )
    }

    var body: some View {
        TabView(selection: handler){
            //主页
            ItemView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
            .tabItem({
                Image(systemName: "house")
                Text("首页")
            })
            .tag(0)
            
            //上架闲置
            UploadView()
                .tabItem({
                    Image(systemName: "gear")
                    Text("上架")
                })
                .tag(1)

            ProfileView()
            .tabItem({
                    Image(systemName: "person")
                    Text("我的")
                })
            .tag(2)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
        }
    }
}
