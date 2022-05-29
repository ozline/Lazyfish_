//
//  ProfileView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI
import Alamofire

struct ProfileView: View {

    @State var userid:String = ""
    @State var name:String = ""
    @State var sex:String = ""
    @State var description:String = ""
    @State var userData:UserType = UserType()
    @State var isLogin:Bool = false
    
    @State var isPresentLogout:Bool = false
    @State var isPresentReview:Bool = false
    
    @State var showAlertLogout:Bool = false
    @State var logoutErrorMsg:String = ""
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("资料")){
                    HStack{
                        Text("学号")
                            .foregroundColor(.gray)
                        Spacer()
                        Text(userid)
                    }
                    HStack{
                        Text("姓名")
                            .foregroundColor(.gray)
                        Spacer()
                        Text(name)
                    }
                    HStack{
                        Text("性别")
                            .foregroundColor(.gray)
                        Spacer()
                        Text(sex)
                    }
                    HStack{
                        Text("签名")
                            .foregroundColor(.gray)
                        Spacer()
                        Text(description)
                    }
                }
                Section(header: Text("管理")){
                    if(Global.isadmin){
                        NavigationLink(destination: ItemReviewView()){
                            HStack{
                                Text("物品审核")
                                    .foregroundColor(.blue)
                            }
                        }
                        NavigationLink(destination: ItemReviewView()){
                            HStack{
                                Text("小黑屋")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    NavigationLink(destination: AddressView()){
                        HStack{
                            Text("收货地址")
                                .foregroundColor(.blue)
                        }
                    }
                }
                if(userid == Global.userid){ //当前用户时才显示
                    Section("我的钱包"){
                        HStack{
                            Text("可用余额")
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(userData.money != nil ? userData.money! : -1.00))
                            Text("元")
                        }
                    }
                    Section(header: Text("设置")){
//                        Button(action:login){
//                            HStack{
//                                Spacer()
//                                Text("软件设置")
//                                Spacer()
//                            }
//                        }
//                        Button(action:login){
//                            HStack{
//                                Spacer()
//                                Text("编辑资料")
//                                Spacer()
//                            }
//                        }
                        Button(action:loginout){
                            HStack{
                                Spacer()
                                Text("退出账号")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }.fullScreenCover(isPresented: $isPresentLogout, content: {
                            if isLogin{
                                ContentView()
                            }else{
                                LoginView(successLogin: $isLogin)
                            }
                        })
                        .alert(isPresented: $showAlertLogout){
                            Alert(title:Text("退出失败"),message: Text(logoutErrorMsg))
                        }
                    }
                }
                
                
            }
            .navigationBarTitle(userid == Global.userid ? "我的" : "用户 "+String(userid))
            .onAppear(){
                userGetByID(userid: userid){
                    (res:Bool,msg:String,data:UserType) in

                    name = (data.realName != nil) ? data.realName! : "NULL"
                    sex = transSex(sex: (data.sex != nil) ? data.sex! : 2)
                    description = (data.sig != nil) ? data.sig! : "NULL"
                    userData = data
                }
                
            }
        }
    }
    
    private func transSex(sex:Int) -> String{
        return sex == 0 ? "男孩子" : sex == 1 ? "女孩子" : "还不知道哦"
    }
    
    private func login(){
        
    }
    
    private func reviewItem(){
        
    }
    
    private func loginout(){
        userLoginout(){
            (res:Bool,msg:String) in
            
            if res{
                Global.islogin = false
                Global.isadmin = false
                Global.token = ""
                self.isPresentLogout.toggle()
            }else{
                self.logoutErrorMsg = msg
                self.showAlertLogout.toggle()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {

    
    static var previews: some View {
        ProfileView()
    }
}
