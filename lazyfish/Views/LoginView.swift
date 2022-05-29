//
//  LoginView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username:String = "052106112"
    @State private var password:String = "mima1216"
    @State private var showAlert:Bool = false
    @Binding var successLogin:Bool
    
    @State private var loginErrorMsg:String = ""

    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("账号")){
                    TextField("教务处账号",text: $username)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.leading)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("密码")){
                    SecureField("教务处密码",text:$password)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.leading)
//                        .keyboardType(.phonePad)
                }
                Section(header: Text("验证码")){
                    
                }
                Button(action:loginUser){
                    HStack{
                        Spacer()
                        Text("登录")
                        Spacer()
                    }
                }
                .alert(isPresented: $showAlert){
                    Alert(title:Text("登录失败"),message: Text(loginErrorMsg))
                }
            }
            .navigationTitle("登录")
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func loginUser() {
        if(username.count != 0 && password.count != 0){
            userLogin(asp: "111", username: username, password: password, verifycode: "100"){
                (result:Bool,msg:String) in
                
                if(result){
                    userInit(){
                        (result:Bool,msg:String) in
                        if(result){
                            successLogin = true
                        }else{
                            loginErrorHandler(msg: msg)
                        }
                    }
                    
                }else{
                    loginErrorHandler(msg: msg)
                }
            }
        }else{
            loginErrorHandler(msg: "学号、密码或验证码不正确")
        }
    }
    
    private func loginErrorHandler(msg:String){
        loginErrorMsg = msg
        self.showAlert.toggle()
    }
}
