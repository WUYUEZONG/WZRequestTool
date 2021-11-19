//
//  File.swift
//  
//
//  Created by mntechMac on 2021/11/19.
//

import UIKit
import Alamofire


protocol WZRequestProtocol {
    
    associatedtype T: WZRequestDelegate
    
    associatedtype DT
    /**
     请求接口数据
     
     ```
     // for example
     enum ATAliSevice: WZRequestDelegate {
         
         // 101240101
         case getWeather(cityCode: Int = 101240101)
     }

     extension ATAliSevice {
         
         var request: (base: String, path: String, method: HTTPMethod, header: [String : String], params: [String : Any]?, encoding: ParameterEncoding) {
             var path = ""
             let method: HTTPMethod = .get
             var header = ["Content-Type": "application/json"]
             let params: [String: Any]? = nil
             let encoding: ParameterEncoding = URLEncoding.default
             switch self {
             case let .getWeather(code):
                 path = "/weather/query?citycode=\(code)"
                 header = ["Content-Type": "application/json", "Authorization": "APPCODE cb0583952663413ab459b90ef3a60459"]
             }
             return ("https://jisutqybmf.market.alicloudapi.com", path, method, header, params, encoding)
         }
     }
     
     // Useage:
     ATNetworkTool<ATAliSevice, [String: Any]>.request(target: .getWeather(), success: { data in }, fail: { e in })
     
     
     ```
     
     - Parameters:
          - target: `WZRequestDelegate` 必须遵循ATURLDelegate
          - shouldCache: 是否缓存返回结果，默认为false，使用 `ATCache: NSCache` 默认支持20个结果的缓存；使用`ATCache.shared`管理
          - success: 请求成功回调
          - fail: 失败回调，参数`AFError`
     */
    static func request(target: T, _ shouldCache: Bool, success:@escaping ((DT)->()), fail:@escaping ((AFError)->()))
    
    static var completeHandler: (_ data: Data, _ successedHandler: @escaping (DT)->(), _ cacheKey: NSString?, _ shouldCache: Bool) -> Void { get }
}


extension WZRequestProtocol {
    
    static var completeHandler: (Data, @escaping (DT)->(), NSString?, Bool) -> Void {
        { data, success, cacheKey, shouldCache in
            
            debugPrint("-------  \(Thread.current) ------- is Main \(Thread.current.isMainThread)")
            if shouldCache, let key = cacheKey {
                WZRequestCache.shared.dataCaches.setObject(data as NSData, forKey: key)
            }
            
            if DT.self == [String: Any].self {
                if let jsonSer = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                   let dict = jsonSer as? [String: Any] {
                    DispatchQueue.main.async {
                        success(dict as! Self.DT)
                    }
                }
            }
            
            if DT.self == String.self {
                DispatchQueue.main.async {
                    success(String(data: data, encoding: .utf8) as! Self.DT)
                }
            }
            
            if DT.self == UIImage.self {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    success(image as! Self.DT)
                }
            }
        }
    }
    
    static func request(target: T, _ shouldCache: Bool = false, success:@escaping ((DT)->()), fail:@escaping ((AFError)->())) {
        
        let r = target.request
        
        let AFRequest = AF.request(r.base + r.path, method: r.method, parameters: r.params, encoding: r.encoding, headers: HTTPHeaders(r.header))
        let key = AFRequest.convertible.urlRequest?.url?.absoluteString as NSString?
        if shouldCache, let k = key, let cache = WZRequestCache.shared.dataCaches.object(forKey: k) {
            completeHandler(cache as Data, success, k, false)
        } else {
            AFRequest.responseData(queue: .global()) { data in
                switch data.result {
                case .success(let result):
                    completeHandler(result, success, key, true)
                case .failure(let e):
                    debugPrint(e.errorDescription ?? "request error")
                    DispatchQueue.main.async {
                        fail(e)
                    }
                }
            }
        }
        
        
    }
    
}
