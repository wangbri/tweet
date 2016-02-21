//
//  AppDelegate.swift
//  tweet
//
//  Created by Brian Wang on 2/15/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    //storyboard parses xml file


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        //whenever user is published as logging out
        
        
        if User.currentUser != nil {
            //go to the logged in screen, i.e. timeline screen
            print("Current user detected: \(User.currentUser?.name)")
        var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as UIViewController
            window?.rootViewController = vc
            //arrow in storyboard executes this line
        }
        return true
    }
    
    func userDidLogout() {
        var vc = storyboard.instantiateInitialViewController()! as UIViewController
        window?.rootViewController = vc
        

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
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        //check if path said oauth, then direct to twitter auth url
        TwitterClient.sharedInstance.openURL(url)
        
        
        
        
        return true
    }


}

