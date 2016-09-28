//
//  ViewController.swift
//  yinlian
//
//  Created by chedao on 16/9/27.
//  Copyright © 2016年 chedao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /** 测试获取流水交易号 */
    fileprivate let tn_normal = "http://101.231.204.84:8091/sim/getacptn"
    /** 调客户端的会跳 */
    fileprivate let scheme = "UPPay"
    /**
     * 环境
     * 01 测试环境
     * 00 正式环境
     */
    fileprivate let mode = "01"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let btn = UIButton()
        btn.frame = CGRect(x: 30, y: 100, width: 200, height: 60)
        btn.setBackgroundImage(UIImage(named: "background" ), for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("点击支付", for: .normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(ViewController.startPay), for: .touchUpInside)
    }
    
    
    //点击发起支付
    func startPay() -> Void {
        
        //从网络获取交易流水号
        let req = URLSession.init(configuration: URLSessionConfiguration.default)
        req.dataTask(with: URLRequest(url: URL(string: tn_normal)!)) { (data, respose, error) in
            if (respose as! HTTPURLResponse).statusCode != 200 {
                req.invalidateAndCancel()
                print("请求失败")
            }else{
                //获取到交易流水号之后调用SDK发起支付
                let tn = String(data: data!, encoding: .utf8)
                //交易流水号不能为空
                if tn != nil && (tn?.characters.count)! > 0 {
                    //self.scheme:必须跟工程配置相同才能收到回调通知
                  UPPaymentControl.default().startPay(tn, fromScheme: self.scheme, mode: self.mode, viewController: self)
                }
            }
            
        }.resume()
    
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

