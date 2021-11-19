//
//  ViewController.swift
//  RequestDemo
//
//  Created by mntechMac on 2021/11/19.
//

import UIKit
import WZRequestTool
import Alamofire

enum DemoService: WZRequestDelegate {
    case demoRequest
}

extension DemoService {
    var request: (base: String, path: String, method: HTTPMethod, header: [String : String], params: [String : Any]?, encoding: ParameterEncoding) {
        
        var base = ""
        var path = ""
        var method: HTTPMethod = .get
        var head: [String : String] = [:]
        var param: [String : Any]? = nil
        var encoding: URLEncoding = .queryString
        
        switch self {
        case .demoRequest:
            path = "some path"
        }
        return (base, path, method, head, param, encoding)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        WZRequestTool<DemoService, [String: Any]>.request(target: .demoRequest) { data in
            
        } fail: { error in
            
        }

        
    }

}

