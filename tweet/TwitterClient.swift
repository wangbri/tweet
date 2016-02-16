//
//  TwitterClient.swift
//  tweet
//
//  Created by Brian Wang on 2/15/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "vfGqPRt4Am7MjJWS08VvPn5mi"
let twitterConsumerSecret = "aWn6h51O0af70unNxLM76jYLzJcy3aG5Ml9IhWvt3NZXuViBCM"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        //class type property (computed)
        struct Static {
            //structs can have properties
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            //can also be all pulled from a plist
        }
        return Static.instance
    }
    
}
