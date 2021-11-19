


import Foundation

/// - Tool: target Type, about your request service
/// - DataType: type of your request`s response data type
///
class WZRequestTool<Tool: WZRequestDelegate, DataType>: WZRequestProtocol {
    typealias T = Tool
    typealias DT = DataType
}
