//
//  ViewController.swift
//  tweet
//
//  Created by Brian Wang on 2/15/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        //TwitterClient caches tokens
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("got request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            //different protocols open different things
            //https, sites; loc, maps
            //cptwitterdemo is a protocol
            
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                //time out of sync can result in fail to get token
        }
    }

}

