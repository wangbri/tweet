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
    var tweetID: NSNumber?
    var retweetCount: NSNumber?
    var likeCount: NSNumber?
    
    var tempDate: NSDate?
    
    
    
    
    
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        tweetID = dictionary["id"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        likeCount = dictionary["favorite_count"] as? Int
        
        
        
        //print(tweetID)
        
        
        
        //tweetID = dictionary["id"]!//.integerValue as Int
        
        //need to parse
        var formatter = NSDateFormatter()
        
        formatter.timeZone = NSTimeZone(name: "CST")
        
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        //created in UTC time
        
        //code for above at NSDateFormatter documentation
        
        
        
        tempDate = formatter.dateFromString(createdAtString!)
        
        print(formatter.timeZone)
        
        
        //gets current hour so you can account for dates that are more than 24 hours and set a different format for them
        print(text)
        //print("created at\(createdAtString)")
        print(tempDate)
        
        
        
        //dateFormatter.dateFormat = /*find out and place date format from http://userguide.icu-project.org/formatparse/datetime*/
        
        //dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "H"
        
        let createdAtTemp = dateFormatter.stringFromDate(tempDate!)
        
        //would prefer static NSDateFormatter
        //could make createdAt a lazy property
        
        print(createdAtTemp)
        
        let createdAtTime: Int? = Int(createdAtTemp)
        //print(createdAtTime)
        
        /*if currentHour > createdAtTime {
            createdAt = finalFormatter.stringFromDate(tempDate!)
            createdAt = "\(createdAt!)h"
        } else if currentHour < createdAtTime {
            finalFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            createdAt = finalFormatter.stringFromDate(tempDate!)
        } else {
            createdAt = finalFormatter.stringFromDate(tempDate!)
        }*/
        
        
        let currentHour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        
        
        if NSCalendar.currentCalendar().isDateInToday(tempDate!) {
            if((createdAtTime! - currentHour) == 0) {
                createdAt = "recently"
            } else {
                createdAt = "\(abs(createdAtTime! - currentHour))h"
            }
            
            
            
        } else {
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            createdAt = dateFormatter.stringFromDate(tempDate!)
        }
        
        
        
        
        /*if date1.compare(date2) == NSComparisonResult.OrderedDescending
        {
        NSLog("date1 after date2");
        } else if date1.compare(date2) == NSComparisonResult.OrderedAscending
        {
        NSLog("date1 before date2");
        } else
        {
        NSLog("dates are equal");
        }*/



        
        
        
        
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        var tweet = Tweet(dictionary: dict)
        return tweet
    }
    
    //parses an array of dictionaries to get an array of tweets
}
