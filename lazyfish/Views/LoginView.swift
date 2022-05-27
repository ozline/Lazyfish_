//
//  LoginView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username:String = ""
    @State private var password:String = ""
    @State private var showAlert:Bool = false
    @Binding var successLogin:Bool

    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("账号")){
                    TextField("教务处账号",text: $username)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.leading)
                        .keyboardType(.phonePad)
                }
                Section(header: Text("密码")){
                    SecureField("教务处密码",text:$password)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.leading)
                        .keyboardType(.phonePad)
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
                    Alert(title:Text("学号、密码或验证码不正确"))
                }
            }
            .navigationTitle("登录")
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func loginUser() {
        if(username.count != 0){
            userid = Int(username)!
            successLogin = true
            return
        }
        
        self.showAlert.toggle()
    }
}
