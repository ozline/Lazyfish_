//
//  Users.swift
//  lazyfish
//
//  Created by ozline on 2022/5/28.
//

import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON


struct Login: Encodable{
    let asp : String
    let passwd : String
    let muser : String
    let username : String
    let verifyCode : String
}

struct Activate: Encodable{
    let asp : String
    let passwd : String
    let muser : String
    let username : String
    let verifyCode : String
}

struct UserType: HandyJSON{
    var avatar : String? //头像储存路径
    var createTime : String? //注册时间
    var deleted : Int? //账号状态 1=可用 0=禁用
    var email : String? //邮箱地址
    var id : String? //学号
    var money : Double? //金钱数量
    var realName : String? //真实姓名
    var nickname : String? //昵称
    var phoneNum : String? //电话号码
    var sex : Int? //性别 0=男 1=女 2=未知
    var sig : String? //个签
    var star : Int? //好评数
    var updateTime : String? //最近登录时间
}

struct AddressType: HandyJSON,Encodable{
    var id : Int = -1
    var userid : String = "-1"
    var address : String = "NULL"
    var isDefault : Bool = false
}
/**
 用户登录
 */
func userLogin(asp:String,username:String,password:String,verifycode:String,action: @escaping (Bool,String) -> Void) {

    let url = Global.host+"/user/activate"

    let login = Login(asp: asp, passwd: password, muser: username, username: username, verifyCode: verifycode)
    AF.request(url,method: .post,parameters: login,encoder: URLEncodedFormParameterEncoder.default).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            if(code != 1){ //此处应当改为==200
                let url = Global.host+"/toLogin"

                let login = Login(asp: asp, passwd: password, muser: username, username: username, verifyCode: verifycode)
                AF.request(url,method: .post,parameters: login,encoder: URLEncodedFormParameterEncoder.default).responseJSON{
                    response in
                    switch(response.result){
                    case .success(let json):
                        let data = JSON(json)
                        let code = data["code"].intValue
                        let msg = data["msg"].stringValue
                        if(code==200){
                            Global.token = data["data"]["token"].stringValue
                        }
                        action(code==200,msg)
                    case .failure(let err):
                        debugPrint(err)
                    }
                }
            }else{
                action(code==200,msg)
            }
        case .failure(let err):
            debugPrint(err)
        }
    }
}

/**
 获取当前登录的用户的信息
 */
func userInit(action: @escaping (Bool,String) -> Void){
    
    let url = Global.host+"/user/user"
    
    AF.request(url,method: .get,headers: Global.headers).responseJSON{
        response in
        
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            if(code==200){
                Global.userid = data["data"]["id"].stringValue
                Global.isadmin = data["data"]["admin"].boolValue
            }
            action(code==200,msg)
        case .failure(let err):
            debugPrint(err)
        }
    }
}


/**
 根据用户ID获取用户信息
 */
func userGetByID(userid:String,action: @escaping (Bool,String,UserType) -> Void){
    let url = Global.host+"/user/getUserById"
    
    let parameters = ["userId":userid]
    
    AF.request(url,method: .post,parameters: parameters,headers: Global.headers).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            
            if code==200{
                if let datas = UserType.deserialize(from: data["data"].dictionaryObject){
                    action(true,msg,datas)
                }else{
                    action(false,msg,UserType())
                }
            }else{
                action(false,msg,UserType())
            }
            
        case .failure(let err):
            debugPrint(err)
        }
    }
}

/**
 用户登出
 */
func userLoginout(action: @escaping (Bool,String) -> Void){
    let url = Global.host+"/user/logout"
    
    AF.request(url,method: .post,headers: Global.headers).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            action(code==200,msg)
        case .failure(let err):
            debugPrint(err)
        }
    }
}


func getAddressList(action: @escaping (Bool,String,[AddressType]) -> Void){
    let url = Global.host+"/user/showAddr"
    
    AF.request(url,method: .get,headers: Global.headers).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            if code==200{
                var list:[AddressType] = []
                for (_,subJSON):(String,JSON) in data["data"]{
                    list.append(AddressType.deserialize(from: subJSON.dictionaryObject)!)
                }
                action(true,msg,list)
            }else{
                action(false,msg,[AddressType()])
            }
        case .failure(let err):
            debugPrint(err)
        }
    }
}

/**
 删除地址
 */
func deleteAddress(id:Int,action: @escaping (Bool,String) -> Void){
    let url = Global.host+"/user/deleteAddr/"+String(id)
    
    AF.request(url,method: .delete,headers: Global.headers).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            action(code==200,msg)
        case .failure(let err):
            debugPrint(err)
        }
    }
}

func updateAddress(id:Int,newAddr:String,isDefault:Bool,action: @escaping (Bool,String) -> Void){
    let url = Global.host+"/user/updateAddr"
    
    let parameters = AddressType(id: id, userid: "", address: newAddr, isDefault: isDefault)
    
    AF.request(url,method: .post,parameters: parameters,encoder: URLEncodedFormParameterEncoder.default,headers: Global.headers).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            action(code==200,msg)
        case .failure(let err):
            debugPrint(err)
        }
    }
}

func addAddress(newAddr:String,action: @escaping (Bool,String) -> Void){
    let url = Global.host+"/user/addAddr"
    
    struct addr:Encodable{
        let address : String
        let isDefault : Int = 1
    }
    
    let parameters = addr(address: newAddr)
    
    AF.request(url,method: .post,parameters: parameters,encoder: URLEncodedFormParameterEncoder.default,headers: Global.headers).responseJSON{
        response in
        switch(response.result){
        case .success(let json):
            let data = JSON(json)
            let code = data["code"].intValue
            let msg = data["msg"].stringValue
            action(code==200,msg)
        case .failure(let err):
            debugPrint(err)
        }
    }
}
