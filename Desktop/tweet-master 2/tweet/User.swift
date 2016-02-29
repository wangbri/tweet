//
//  User.swift
//  tweet
//
//  Created by Brian Wang on 2/16/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit

var _currentUser: User?
//global object as a "class/type variable"
let currentUserKey = "kCurrentUserKey"

let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: NSURL?
    var profileBackUrl: NSURL?
    var tagline: String?
    var dictionary: NSDictionary
    
    var followersCount: Int?
    var followingCount: Int?
    var tweetsCount: Int?
    
    //constructor to take in a dictionary input and set variables
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        //profileImageUrl = dictionary["profile_image_url"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        let profileBackUrlString = dictionary["profile_background_image_url_https"] as? String
        if let profileBackUrlString = profileBackUrlString {
            profileBackUrl = NSURL(string: profileBackUrlString)
        }
        
        tagline = dictionary["description"] as? String
        self.dictionary = dictionary
        
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetsCount = dictionary["statuses_count"] as? Int
        
        
    }
    
    //persistence, keep user data
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        //defaultcenter same as singleton pattern
        
        
    }
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        //logged out or just boot up
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        if data != nil {
        let dictionary: NSDictionary?
        do {
        try dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
        _currentUser = User(dictionary: dictionary!)
    } catch {
        print(error)
        }
        }
        }
        return _currentUser
        }
        
        
        set(user) {
            _currentUser = user
            //User need to implement NSCoding; but, JSON also serialized by default
            if let _ = _currentUser {
                var data: NSData?
                do {
                    try data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    print(error)
                }
            }
        }
    }

}
