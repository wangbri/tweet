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
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    //constructor to take in a dictionary input and set variables
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        self.dictionary = dictionary
    }
    
    //persistence, keep user data
    
    class var currentUser: User? {
        get {
        //currentUser is computed property
            if _currentUser == nil {
                print("current user is nil")
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do {
                        var dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0)) as? NSData
                        let userDictionary: NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(dictionary!) as! NSDictionary
                        _currentUser = User(dictionary: userDictionary)
                        print("there exists a current user")
                    } catch {
                        print("exception thrown at User class")
                    }
        
                } //catch {
                //check if there exists a currentUser or just booting up
                    //print("no user exists yet")
                //}
        
            }
            print("GETTING")
        
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            print("SETTING")
            
            let userData: NSData = NSKeyedArchiver.archivedDataWithRootObject((user?.dictionary)!)
            //let userDictionary: NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(userData) as! NSDictionary
            
            //to maintain persistence, User has to implement NSCoding to describe how you want to serialize and deserialize objects, JSON is also serializable by default
            //if _currentUser != nil {
            
            
            if _currentUser != nil {
                do {
                    var data = try NSJSONSerialization.JSONObjectWithData(userData, options:NSJSONReadingOptions(rawValue: 0))
                    
                    
                    //30.09 https://vimeo.com/107319225
                    
                    
                    
                    //if current user is not nil, change to JSON
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                    //saving/storing the current user to be perhaps accessed later and tying the data with a key
                    NSUserDefaults.standardUserDefaults().synchronize()
                    //saving
                    print("user archived")
                
                    //with throws, needs to try
                } catch {
                    print("clearing out current user (logging out)")
                    
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }

}
