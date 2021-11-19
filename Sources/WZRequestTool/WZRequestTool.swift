


import Foundation

/// - Tool: target Type, about your request service
/// - DataType: type of your request`s response data type
///
class WZRequestTool<Tool: WZRequestDelegate, DataType>: WZRequestProtocol {
    typealias T = Tool
    typealias DT = DataType
}

class WZRequestCache: NSCache<NSString, NSData> {
    
    static let shared = ATCache()
    
    lazy var dataCaches: NSCache<NSString, NSData> = {
        let c = NSCache<NSString, NSData>()
        c.name = "ATCacheDataCaches"
        c.countLimit = 20
        return c
    }()
}
