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
    var createdAt: String?//NSDate?
    
    
    
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        //need to parse
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        //code for above at NSDateFormatter documentation
        let tempDate = formatter.dateFromString(createdAtString!)
        
        var finalFormatter = NSDateFormatter()
        finalFormatter.dateFormat = "H"
        
        createdAt = finalFormatter.stringFromDate(tempDate!)
        
        //would prefer static NSDateFormatter
        //could make createdAt a lazy property
        
        print(createdAt)
        
        
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        //gets current hour so you can account for dates that are more than 24 hours and set a different format for them
        print(hour)
        
        
        
        
        
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
