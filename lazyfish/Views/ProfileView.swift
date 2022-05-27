//
//  ProfileView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView{
            List{
                
                Button(action:login){
                    HStack{
                        Spacer()
                        Text("登录")
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("我的")
        }
    }
    
    private func login(){
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
