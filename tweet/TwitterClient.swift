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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    //will hold the closure until ready to login
    
    class var sharedInstance: TwitterClient {
        //class type property (computed)
        struct Static {
            //structs can have properties
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            //can also be all pulled from a plist
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("home timeline: \(response)")
            
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            
                completion(tweets: tweets, error: nil)
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
        
        
    }
    
    func retweetItem(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(params!["id"] as! Int).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            var tweet = Tweet.tweetAsDictionary(response as! NSDictionary)
            print("retweeted")
            completion(tweet: tweet, error: nil)
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
                completion(tweet: nil, error: error)
        }
    }
    
    func likeItem(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            var tweet = Tweet.tweetAsDictionary(response as! NSDictionary)
            print("liked tweet")
            completion(tweet: tweet, error: nil)
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
                
        }
    }
    
    
    
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        //call completion block with either user or error
        
        loginCompletion = completion
        
        //originally in viewcontroller
        //fetch request token & redirect to authorization page
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
                self.loginCompletion?(user: nil, error: error)
                //time out of sync can result in fail to get token
            }
    }
    
    func openURL(url: NSURL) {
        //originally in appdelegate
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            //accessToken gives access to User's
            
            //twitter api documentation
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                //print("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user //user is now set as currentUser
                print("user: \(user.name)")
                
                
                
                self.loginCompletion?(user: user, error: nil)
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            
            
            
            
            
            }) { (error: NSError!) -> Void in
                print("failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
        
    }
        
        
        
}
    
    
    

