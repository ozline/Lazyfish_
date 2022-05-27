//
//  LoginView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username:String = ""

    var body: some View {
        TextField("input",text: $username)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
