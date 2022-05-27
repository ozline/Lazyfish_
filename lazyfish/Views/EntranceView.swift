//
//  EntranceView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct EntranceView: View {
    
    @State var isLogin:Bool = false
    var body: some View {
        return Group{
            if isLogin { //登录成功进入主界面
                ContentView()
            }else{
                LoginView(successLogin: $isLogin)
            }
        }
    }
}

struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView()
    }
}
