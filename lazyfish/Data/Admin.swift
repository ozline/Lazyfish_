//
//  Admin.swift
//  lazyfish
//
//  Created by ozline on 2022/5/29.
//

import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON

struct Page:Encodable{
    let currentPage : Int
    let pageSize : Int
}


func getReviewList(current:Int,size:Int,action: @escaping (Bool,String,[Commodity],Int) -> Void){
    let url = Global.host+"/admin/showNotChecked"
    
    let page = Page(currentPage: current, pageSize: size)
    AF.request(url,method: .post,parameters: page,encoder: URLEncodedFormParameterEncoder.default,headers: Global.headers).responseJSON{
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

func passCommodityByIds(commodityid:Int){
    let url = Global.host+"/admin/passCommodityByIds"
    
//    AF.request(
}
