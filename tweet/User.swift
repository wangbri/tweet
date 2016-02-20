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

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: NSURL?
    var tagline: String?
    var dictionary: NSDictionary
    
    //constructor to take in a dictionary input and set variables
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        //profileImageUrl = dictionary["profile_image_url"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
        self.dictionary = dictionary
    }
    
    //persistence, keep user data
    
    static var _currentUser: User?
    
    
    class var currentUser: User? {
        get {
            //currentUser is computed property
            if _currentUser == nil {
            
            let defaults = NSUserDefaults.standardUserDefaults()
        
            let userData = defaults.objectForKey("currentUserData") as? NSData
            //NSUserDefaults like "cookies"
            
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    
                    
                    _currentUser = User(dictionary:dictionary)
                }
            }
        
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary, options: [])
                
                defaults.setObject(data, forKey: "currenUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
                
            
            
            defaults.setObject(user, forKey: "currentUser")
            //must comply with NSCoding, but can "hack" and change user back to JSON.
            
            defaults.synchronize()
        }
        
            
    }

}
