//
//  PaymentView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct PaymentView: View {
    
    @State var selectedIndex:Int = 0
    @State var commodityId = 0
    @State var commodityData = Commodity()
    
    @Binding var show:Bool
    
    var body: some View {
        NavigationView{
            List{
                Section("收货地址"){
                    Picker(selection: $selectedIndex,label: Text("收货地址")){
                        ForEach(0 ..< Global.addressList.count){
                            Text(Global.addressList[$0].address ?? "NULL")
                        }
                    }
                }
                
                Button(action: purchaseConfirm){
                    Text("确认下单")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("下单 - \(commodityData.title ?? "" )")
        }
    }
    
    private func purchaseConfirm(){
        show.toggle()
    }
}
