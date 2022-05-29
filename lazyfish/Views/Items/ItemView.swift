//
//  ItemView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var itemid:Int
    @State var itemData:Commodity = Commodity()
    

    @State var showAlertPass:Bool = false
    @State var passErrorMsg:String = ""
    
    @State var showAlertReject:Bool = false
    @State var rejectErrorMsg:String = ""
    
    @State var isPresentedViewSeller:Bool = false
    @State var isPresentedPurchase:Bool = false

    var body: some View {
        List{
            Section("基本"){
                HStack{
                    Text("商品编号")
                    Spacer()
                    Text(String(itemData.id ?? -1))
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("卖家学号")
                    Spacer()
                    Text(itemData.userId ?? "null")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("发布时间")
                    Spacer()
                    Text(itemData.createTime ?? "null")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("最后更新")
                    Spacer()
                    Text(itemData.updateTime ?? "null")
                        .foregroundColor(.gray)
                }
            }
            Section("物品信息"){
                HStack{
                    Text("名称")
                    Spacer()
                    Text(itemData.title ?? "null")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("类型")
                    Spacer()
                    Text(itemData.type ?? "null")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("简介")
                    Spacer()
                    Text(itemData.description ?? "null")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("原价")
                    Spacer()
                    Text(String(itemData.oldPrice ?? -1))
                        .foregroundColor(.gray)
                    Text("元")
                }
                HStack{
                    Text("现价")
                    Spacer()
                    Text(String(itemData.price ?? -1))
                        .foregroundColor(.gray)
                    Text("元")
                }
            }
            //下单
            Section("可用操作"){
                if(((itemData.userId == nil) ? "0" : itemData.userId!) == Global.userid){
                    Button(action:purchase){
                        HStack{
                            Text("下单")
                                .foregroundColor(.red)
                        }
                    }
                    .sheet(isPresented: $isPresentedPurchase){
                        PaymentView(commodityId: itemData.id ?? -1, commodityData: itemData,show: $isPresentedPurchase)
                    }
                    Button(action:viewUser){
                        HStack{
                            Text("查看卖家个人资料")
                                .foregroundColor(.blue)
                        }
                    }
                    .sheet(isPresented: $isPresentedViewSeller){
                        ProfileView(userid:itemData.userId!)
                    }
                }
            }
            
            //商品审核
            if(Global.isadmin){
                Section("管理"){
                    if((itemData.checked == nil) ? false : !itemData.checked!){
                        Button(action:passItem){
                            HStack{
                                Spacer()
                                Text("通过")
                                    .foregroundColor(.blue)
                                Spacer()
                            }
                        }
                        .alert(isPresented: $showAlertPass){
                            Alert(title:Text("通过失败"),message: Text(passErrorMsg))
                        }
                        Button(action:rejectItem){
                            HStack{
                                Spacer()
                                Text("不通过")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                        .alert(isPresented: $showAlertReject){
                            Alert(title:Text("通过失败"),message: Text(rejectErrorMsg))
                        }
                    }
                }
            }
        }
        .navigationTitle((itemData.title == nil) ? "NULL" : itemData.title!)
    }
    
    private func purchase(){
        isPresentedPurchase.toggle()
    }
    
    private func viewUser(){
        isPresentedViewSeller.toggle()
    }
    
    /**
     通过审核
     */
    private func passItem(){
        passCommodityByIds(commodityid: itemid){
            (res:Bool,msg:String) in
            if res{
                self.presentationMode.wrappedValue.dismiss()
            }else{
                passErrorMsg = msg
                showAlertPass.toggle()
            }
        }
    }
    
    /**
     审核失败
     */
    private func rejectItem(){
        rejectCommodityByIds(commodityid: itemid){
            (res:Bool,msg:String) in
            if res{
                self.presentationMode.wrappedValue.dismiss()
            }else{
                rejectErrorMsg = msg
                showAlertReject.toggle()
            }
        }
    }
}
