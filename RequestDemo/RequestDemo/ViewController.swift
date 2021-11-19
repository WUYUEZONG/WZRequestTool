//
//  ViewController.swift
//  RequestDemo
//
//  Created by mntechMac on 2021/11/19.
//

import UIKit
import WZRequestTool

enum DemoService: WZRequestDelegate {
    case demoRequest
}

extension DemoService {
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    WZRequestTool<DemoService,[String: Any]>.request(target: <#T##T#>, success: <#T##(DT) -> Void#>, fail: <#T##(AFError) -> Void#>)

}

