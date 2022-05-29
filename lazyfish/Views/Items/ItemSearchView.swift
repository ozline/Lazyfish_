//
//  ItemSearchView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/29.
//

import SwiftUI

struct ItemSearchView: View {
    @State var listPage = "1"
    @State var pageSize = "10"
    
    @State var commodityList:[Commodity] = []
    
    @State var totalNum:Int = 0
    @State var pages:Int = 0
    @State var selectedIndex:Int = 0
    
    @State var seachMsg = ""
    
    var body: some View {
        NavigationView{
            List(){
                SearchBar(text: $seachMsg, placeholder: "待搜索关键词"){
                    (msg:String) in
                    
                    print(msg)
                }
                Section("待审列表"){
                    ForEach(commodityList,id: \.id){ commodity in
                        if(commodity.id != nil){
                            NavigationLink((commodity.title != nil) ? commodity.title! : "Unknow",destination: ItemView(itemid: commodity.id!,itemData: commodity))
                        }
                    }
                }
                Section("操作"){
                    HStack{
                        Text("第")
                        Spacer()
                        TextField("0.00",text: $listPage)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.leading)
                            .keyboardType(.numberPad)
                        Text("页")
                    }
                    Button(action: refresh){
                        Text("刷新")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("搜索")
            .onAppear(){
                getReviewList(current: 1, size: 10){
                    (res:Bool,msg:String,list:[Commodity],total:Int) in
                    
                    if res{
                        totalNum = total
    //                    let tmp = ceil(Double(totalNum)/Double(pageSize)!)
                        pages = Int(ceil(Double(totalNum)/Double(pageSize)!))
                        commodityList = list
                    }
                }
            }
        }
    }
    
    private func refresh(){
        getReviewList(current: Int(listPage)!, size: Int(pageSize)!){
            (res:Bool,msg:String,list:[Commodity],total:Int) in
            if res{
                totalNum = total
                pages = Int(ceil(Double(totalNum)/Double(pageSize)!))
                commodityList = list
            }
            print(pages)
        }
    }
}
