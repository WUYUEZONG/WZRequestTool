//
//  WZRequestCache.swift
//  
//
//  Created by mntechMac on 2021/11/19.
//

import Foundation

class WZRequestCache: NSCache<NSString, NSData> {
    
    static let shared = WZRequestCache()
    
    lazy var dataCaches: NSCache<NSString, NSData> = {
        let c = NSCache<NSString, NSData>()
        c.name = "ATCacheDataCaches"
        c.countLimit = 20
        return c
    }()
}
