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
