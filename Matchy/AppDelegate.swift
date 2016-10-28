//
//  AppDelegate.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/24.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FIRApp.configure()
        
        var viewController: UIViewController
        
        let ud = NSUserDefaults.standardUserDefaults()
        let user_uid = ud.objectForKey("uid") as? String
        
        //表示するビューコントローラーを指定
        print("AppDelegate -> user_uid = \(user_uid);")
        
        if user_uid != nil { // uid作成済み
            
            if let isDoneRegistHS = ud.objectForKey("isDoneRegistHS") as? String { // HS
                if isDoneRegistHS == "true" { // HS登録済
                    viewController = UIStoryboard(name: "HSTopTab",bundle:nil).instantiateInitialViewController()! as! UITabBarController
                } else { // HS未登録
                    viewController = UIStoryboard(name: "RegistrationHS",bundle:nil).instantiateInitialViewController()! as! UINavigationController
                }
            } else if let isDoneRegistUniv = ud.objectForKey("isDoneRegistUniv") as? String { // Univ
                if isDoneRegistUniv == "true" { // Univ登録済　まだ未完成ここ
                    viewController = UIStoryboard(name: "UnivTopTab",bundle:nil).instantiateInitialViewController()! as! UITabBarController
                } else { // Univ未登録　まだ未完成ここ
                    viewController = UIStoryboard(name: "RegistrationUniv",bundle:nil).instantiateInitialViewController()! as! UINavigationController
                }
            } else {
                viewController = UIStoryboard(name: "てきとう",bundle:nil).instantiateInitialViewController()! as! UINavigationController
            }
            
        } else { // 未登録
            viewController = UIStoryboard(name: "Top",bundle:nil).instantiateInitialViewController()! as! UINavigationController
        }
        
        window?.rootViewController = viewController
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

