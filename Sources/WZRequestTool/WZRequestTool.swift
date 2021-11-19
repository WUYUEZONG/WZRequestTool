


/// - Tool: target Type, about your request service
/// - DataType: type of your request`s response data type
///
open class WZRequestTool<Tool: WZRequestDelegate, DataType>: WZRequestProtocol {
    public typealias T = Tool
    public typealias DT = DataType
}
