//
//  TestView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
            TabView{
                Text("PAGE ONE")
                    .tabItem({
                        Image(systemName: "house")
                        Text("Home")
                    })
                
                Text("PAGE TWO")
                    .tabItem({
                        Image(systemName: "gear")
                        Text("Gear")
                    })
                
                Text("PAGE THREE")
                    .tabItem({
                        Image(systemName: "person")
                        Text("Home")
                    })
            }
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
