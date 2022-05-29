//
//  ItemReviewView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/29.
//

import SwiftUI

struct ItemReviewView: View {
    @State var listPage = "1"
    @State var pageSize = "10"
    
    @State var commodityList:[Commodity] = []
    
    @State var totalNum:Int = 0
    @State var pages:Int = 0
    @State var selectedIndex:Int = 0
    
    var body: some View {
        List(){
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
            Section("待审列表 - 共计 \(totalNum) 个"){
                ForEach(commodityList,id: \.id){ commodity in
                    if(commodity.id != nil){
                        NavigationLink((commodity.title != nil) ? commodity.title! : "Unknow",destination: ItemView(itemid: commodity.id!,itemData: commodity))
                    }
                }
            }
        }
        .navigationTitle("审核")
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
