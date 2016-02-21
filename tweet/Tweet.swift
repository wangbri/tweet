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
        
        let currentHour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        //gets current hour so you can account for dates that are more than 24 hours and set a different format for them
        
        finalFormatter.dateFormat = "H"
        
        let createdAtTemp = finalFormatter.stringFromDate(tempDate!)
        
        //would prefer static NSDateFormatter
        //could make createdAt a lazy property
        
        let createdAtTime: Int? = Int(createdAtTemp)
        print(createdAtTime)
        
        /*if currentHour > createdAtTime {
            createdAt = finalFormatter.stringFromDate(tempDate!)
            createdAt = "\(createdAt!)h"
        } else if currentHour < createdAtTime {
            finalFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            createdAt = finalFormatter.stringFromDate(tempDate!)
        } else {
            createdAt = finalFormatter.stringFromDate(tempDate!)
        }*/
        
        
        if NSCalendar.currentCalendar().isDateInToday(tempDate!) {
            createdAt = finalFormatter.stringFromDate(tempDate!)
            createdAt = "\(createdAt!)h"
        } else {
            finalFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            createdAt = finalFormatter.stringFromDate(tempDate!)
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
    //parses an array of dictionaries to get an array of tweets
}
