//
//  Items.swift
//  lazyfish
//
//  Created by ozline on 2022/5/29.
//

import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON

struct ItemType:HandyJSON{
    var id: Int?
    var name: String?
}

struct Commodity:HandyJSON{
    var id : Int?
    var title : String?
    var description : String?
    var oldPrice : Double?
    var price : Double?
    var type : String?
    var pictures : String?
    var checked : Bool?
    var deleted : Int?
    var userId : String?
    var createTime : String?
    var updateTime : String?
    var version : Int?
    var vis : Int?
}


/**
 获取商品类型(在软件加载时即访问)
 */

func getCommodityType(action: @escaping (Bool,String) -> Void ){
    let url = Global.host+"/commodity/type"
    
    AF.request(url,method: .get).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            
            if code==200{
                Global.itemTypes = []
                for (_,subJSON):(String,JSON) in data["data"]{
                    Global.itemTypes.append(ItemType.deserialize(from: subJSON.dictionaryObject)!)
                }
                action(true,msg)
            }else{
                action(false,msg)
            }
            
            
        case .failure(let err):
            debugPrint(err)
        }
    }
}

func getItemList(current:Int,size:Int, action: @escaping (Bool,String,[Commodity],Int) -> Void){
    let url = Global.host+"/commodity/list"
    
    struct Page:Encodable{
        let page : Int
        let pageSize : Int
    }
    
    let parameters = Page(page: current, pageSize: size)
    
    AF.request(url,method: .post,parameters: parameters,encoder: URLEncodedFormParameterEncoder.default).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            
            if code==200{
                var list:[Commodity] = []
                let total = data["data"]["total"].intValue
                for (_,subJSON):(String,JSON) in data["data"]["records"]{
                    list.append(Commodity.deserialize(from: subJSON.dictionaryObject)!)
                }
                action(true,msg,list,total)
            }else{
                action(false,msg,[Commodity()],-1)
            }
        case .failure(let err):
            debugPrint(err)
        }
    }
}

func searchCommodity(current:Int,size:Int,searchKey:String,sortType:Int,action: @escaping (Bool,String,[Commodity],Int) -> Void){
    let url = Global.host+"/commodity/search"
    
    struct Search:Encodable{
        var page : Int
        var size : Int
        var sortBy : String = "price"
        var maxPrice : Double = 2147483647.00
        var minPrice : Double = -1.00
        var searchKey : String = ""
        var type : String = ""
        var sortType : Int = 1
    }
    
    let parameters = Search(page: current, size: size,searchKey: searchKey)
    
    AF.request(url,method: .post,parameters: parameters,encoder: URLEncodedFormParameterEncoder.default).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            if code==200{
                var list:[Commodity] = []
                let total = data["data"]["total"].intValue
                for (_,subJSON):(String,JSON) in data["data"]["docList"]{
                    list.append(Commodity.deserialize(from: subJSON.dictionaryObject)!)
                }
                action(true,msg,list,total)
            }else{
                action(false,msg,[Commodity()],-1)
            }
        case .failure(let err):
                debugPrint(err)
        }
    }
    
}
