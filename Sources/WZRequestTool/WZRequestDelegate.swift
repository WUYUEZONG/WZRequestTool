//
//  WZRequestDelegate.swift
//  
//
//  Created by mntechMac on 2021/11/19.
//

import Foundation
import Alamofire

protocol WZRequestDelegate {
    
    /// - base: 域名，如：https://www.wyz.com
    /// - path: 路径
    /// - method: 请求方式
    /// - header: 请求头
    /// - params: 请求参数，可为空
    /// - encoding: 参数编码方式
    ///
    var request: (base: String, path: String, method: HTTPMethod, header: [String: String], params: [String: Any]?, encoding: ParameterEncoding) { get }
}
