//
//  ProfileView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct ProfileView: View {

    @State var userid:Int = 0
    @State var name:String = ""
    @State var sex:String = ""
    @State var description:String = ""
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("信息")){
                    Text("学号:\(userid)")
                    Text("姓名:\(name)")
                    Text("性别:\(sex)")
                    Text("描述:\(description)")
                }
                if(userid == Global.userid){ //当前用户时才显示
                    Section(header: Text("设置")){
                        Button(action:login){
                            HStack{
                                Spacer()
                                Text("软件设置")
                                Spacer()
                            }
                        }
                        Button(action:login){
                            HStack{
                                Spacer()
                                Text("资料设置")
                                Spacer()
                            }
                        }
                    }
                }
                
                
            }
            .navigationBarTitle(userid == Global.userid ? "我的" : "用户 "+String(userid))
            .onAppear(){
                print("1111")
                
            }
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
