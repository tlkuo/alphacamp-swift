//
//  AppDelegate.swift
//  notification
//
//  Created by martin on 2016/4/1.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit
import Batch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var activeCounter: Int = 0
    var inactiveCounter: Int = 0
    var backgroundCounter: Int = 0
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // local notification
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)
        
        application.registerUserNotificationSettings(settings)
        
        let localNotification = UILocalNotification()
        let now = NSDate()
        let notiDate = now.dateByAddingTimeInterval(10)
        
        localNotification.fireDate = notiDate
        localNotification.alertBody = "This is local alert body"
        localNotification.alertAction = "This is local alert action"
        localNotification.userInfo = nil
        //localNotification.repeatInterval = .Minute
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.applicationIconBadgeNumber = 1
        
        application.scheduleLocalNotification(localNotification)
        
        // remote notification
        
        // Start Batch
        Batch.startWithAPIKey("DEV56FDF604CAA918DF1D4CC1CC791")
        
        // Register for push notifications
        BatchPush.registerForRemoteNotifications()
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print(notification.alertAction)
        print(notification.alertBody)
        
        application.applicationIconBadgeNumber = 0
        
        if application.applicationState == .Active {
            activeCounter += 1
        } else if application.applicationState == .Inactive {
            inactiveCounter += 1
        } else if application.applicationState == .Background {
            backgroundCounter += 1
        }

        // option 1
        application.cancelAllLocalNotifications()

        // option 2
        if let notifications = application.scheduledLocalNotifications {

            for noti in notifications {
                application.cancelLocalNotification(noti)
            }
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)

        BatchPush.dismissNotifications()
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
        
        application.applicationIconBadgeNumber = 0
        
        //print("active: \(activeCounter) inactive: \(inactiveCounter) background: \(backgroundCounter)")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

