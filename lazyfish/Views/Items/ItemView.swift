//
//  ItemView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct ItemView: View {
    
    @State var itemid:Int
    @State var itemData:Commodity = Commodity()

    var body: some View {
        List{
            Section("基本"){
                HStack{
                    Text("商品编号")
                    Spacer()
                    Text((itemData.id == nil) ? "NULL" : String(itemData.id!))
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("卖家学号")
                    Spacer()
                    Text((itemData.userId == nil) ? "-1" : itemData.userId!)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("发布时间")
                    Spacer()
                    Text((itemData.createTime == nil) ? "NULL" : itemData.createTime!)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("最后更新")
                    Spacer()
                    Text((itemData.updateTime == nil) ? "NULL" : itemData.updateTime!)
                        .foregroundColor(.gray)
                }
            }
            Section("物品信息"){
                HStack{
                    Text("名称")
                    Spacer()
                    Text((itemData.title == nil) ? "NULL" : String(itemData.title!))
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("类型")
                    Spacer()
                    Text((itemData.type == nil) ? "NULL" : String(itemData.type!))
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("简介")
                    Spacer()
                    Text((itemData.description == nil) ? "NULL" : String(itemData.description!))
                        .foregroundColor(.gray)
                }
            }
            //下单
            Section("可用操作"){
                if(((itemData.userId == nil) ? "0" : itemData.userId!) == Global.userid){
                    Button(action:purchase){
                        HStack{
                            Spacer()
                            Text("下单")
                                .foregroundColor(.blue)
                            Spacer()
                        }
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
                        Button(action:rejectItem){
                            HStack{
                                Spacer()
                                Text("不通过")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle((itemData.title == nil) ? "NULL" : itemData.title!)
    }
    
    private func purchase(){
        
    }
    
    private func passItem(){
        
    }
    
    private func rejectItem(){
        
    }
}
