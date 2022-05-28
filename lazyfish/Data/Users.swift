//
//  Users.swift
//  lazyfish
//
//  Created by ozline on 2022/5/28.
//

import Foundation
import Alamofire
import SwiftyJSON


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

struct User: Encodable{
    let avatar : String //头像储存路径
    let createTime : String //注册时间
    let deleted : Int //账号状态 1=可用 0=禁用
    let email : String //邮箱地址
    let id : String //学号
    let money : Double //金钱数量
    let nickname : String //昵称
    let phoneNum : String //电话号码
    let sex : Int //性别 0=男 1=女 2=未知
    let sig : String //个签
    let star : Int //好评数
    let updateTime : String //最近登录时间
}
/**
 用户登录
 */
func userLogin(asp:String,username:String,password:String,verifycode:String,action: @escaping (Bool,String) -> Void) {

    //toLogin，登录获取Token
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
}

/**
 获取登录用户的信息
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
                Global.userid = data["data"]["id"].intValue
                Global.isadmin = data["data"]["admin"].boolValue
            }
            action(code==200,msg)
        case .failure(let err):
            debugPrint(err)
        }
    }
}

func userGetByID(userid:String,action: @escaping ())
