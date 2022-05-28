//
//  Global.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

//  存一些全局变量

import Foundation
import Alamofire

struct Global{
    static var userid = 0 //这里表示学号
    static var islogin = false //是否已登录
    static var token = "" //jwtToken
    static var isadmin = false //是否是管理员
    static let host = "http://175.178.96.246:8080" //api请求域名
    static var headers:HTTPHeaders = [
        "token" : token,
        "Content-Type": "application/x-www-form-urlencoded"
    ]
}
