//
//  Tweet.swift
//  tweet
//
//  Created by Brian Wang on 2/16/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        //need to parse
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        //code for above at NSDateFormatter documentation
        createdAt = formatter.dateFromString(createdAtString!)
        //would prefer static NSDateFormatter
        //could make createdAt a lazy property
        
        
        
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    //parses an array of dictionaries to get an array of tweets
}
