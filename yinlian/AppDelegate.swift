//
//  AppDelegate.swift
//  yinlian
//
//  Created by chedao on 16/9/27.
//  Copyright © 2016年 chedao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        UPPaymentControl.default().handlePaymentResult(url) { (code, data) in
            
            if code == "success"{
                 print("支付成功")
                //判断签名数据是否存在
                if data == nil{
                    //没有签名数据，建议商户app后台查询交易结果
                    return
                }
                let signData = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions(rawValue: UInt(0)))
                let sign = String(data: signData, encoding: .utf8)
                
                //跟后台验证签名
                if self.verify(sign: sign!) {
                    //支付成功且验证签名成功，展示支付成功提示
                    
                }else{
                    //验证签名失败，交易结果数据被篡改，商户app后台交易结果查询
                    
                }
               
            }else if code == "fail"{
                print("交易失败")
            }else if code == "cancel"{
                print("用户取消")
            }
            
            
        }
        
        return true
    }

    func verify(sign:String) -> Bool {
        
        //发送证书同后台验证，成功返回 true 不成功返回 false
        return true
        
    }
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

