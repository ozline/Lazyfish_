//
//  AddressView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct AddressView: View {
    @State var newAddress:String = ""
    @State var currentID:Int = -1
    @State var currendIsDefault:Bool = false
    
    @State var isPresented:Bool = false
    @State var isPresentedNew:Bool = false
    @State var isPresentedAlert:Bool = false
    @State var alertMessage:String = ""
    
    var body: some View {
        List(){
            Section("点击编辑地址"){
                ForEach(Global.addressList,id: \.id){ address in
                    HStack{
                        Text(address.isDefault ? "(默认收货地址) - \(address.address)" : address.address)
                            .sheet(isPresented: $isPresented){
                                NavigationView{
                                    List{
                                        Section("地址"){
                                            TextEditor(text: $newAddress)
                                        }
                                        Section(){
                                            Button(action:updateAddress){
                                                Text("更新地址")
                                                    .foregroundColor(.blue)
                                            }
                                            if(!currendIsDefault){
                                                Button(action:setDefault){
                                                    Text("设为默认")
                                                        .foregroundColor(.blue)
                                                }
                                            }
                                            Button(action:deleteAddress){
                                                Text("删除地址")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        Button(action:{
                                            isPresented.toggle()
                                        }){
                                            Text("返回")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .navigationTitle("更新收货地址")
                                    .alert(isPresented: $isPresentedAlert){
                                        Alert(title: Text("错误"),
                                              message: Text(alertMessage),
                                              dismissButton: .default(Text("好的")))
                                    }
                                }
                            }
                        .onTapGesture(){
                            currentID = address.id
                            newAddress = address.address
                            currendIsDefault = address.isDefault
                            isPresented.toggle()
                        }
                    }
                }
            }
            Button("添加地址"){
                isPresentedNew.toggle()
            }
            .sheet(isPresented: $isPresentedNew){
                NavigationView{
                    List{
                        Section("地址"){
                            TextEditor(text: $newAddress)
                            Button(action:updateAddress){
                                Text("添加地址")
                                    .foregroundColor(.blue)
                            }
                        }
                        Button(action:{
                            isPresentedNew.toggle()
                        }){
                            Text("返回")
                                .foregroundColor(.blue)
                        }
                    }
                    .navigationTitle("添加收货地址")
                    .alert(isPresented: $isPresentedAlert){
                        Alert(title: Text("错误"),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("好的")))
                    }
                }
            }
        }
        .navigationTitle("收货地址")
        .onAppear(){
            refresh()
        }
    }
    
    private func addAddress(){
        lazyfish.addAddress(newAddr: newAddress){
            (res:Bool,msg:String) in
            if res{
                refresh()
                isPresented.toggle()
            }else{
                alertMessage = msg
                isPresentedAlert.toggle()
            }
        }
    }
    
    private func deleteAddress(){
        lazyfish.deleteAddress(id: currentID){
            (res:Bool,msg:String) in
            if res{
                refresh()
                isPresented.toggle()
            }else{
                alertMessage = msg
                isPresentedAlert.toggle()
            }
        }
    }
    
    private func updateAddress(){
        lazyfish.updateAddress(id: currentID, newAddr: newAddress, isDefault: currendIsDefault){
            (res:Bool,msg:String) in
            if res{
                refresh()
                isPresented.toggle()
            }else{
                alertMessage = msg
                isPresentedAlert.toggle()
            }
        }
    }
    
    private func setDefault(){
        lazyfish.updateAddress(id: currentID, newAddr: newAddress, isDefault: true){
            (res:Bool,msg:String) in
            if res{
                refresh()
                isPresented.toggle()
            }else{
                alertMessage = msg
                isPresentedAlert.toggle()
            }
        }
    }
    
    private func refresh(){
        getAddressList(){
            (res:Bool,msg:String,list:[AddressType]) in
            
            if res{
                Global.addressList = list
            }else{
                print(res,msg,list)
            }
        }
    }
}
