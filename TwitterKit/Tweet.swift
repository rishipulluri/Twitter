//
//  Tweet.swift
//  TwitterKit
//
//  Created by saritha on 2/14/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var id: AnyObject
    var user:User
    var text: String?
    var createdAtString:String?
    var createdAt:NSDate?
    
    
    init(dictionary: NSDictionary)
    {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        // id = dictionary["id"] as! String
        id = dictionary["id"]!
       // print("\(id)")
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]
    {
        var tweets = [Tweet]()
        
        for dictionary in array
        {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
    func getDifference() ->String
    {
        let elapsedTime = NSDate().timeIntervalSinceDate(createdAt!)
        let timeofreal = NSInteger(elapsedTime)
        let (year, month, day, hours, minutes, seconds) = secondstohoursminsec(timeofreal)
        if year > 1
        {
            return "\(year)year"
        }
        else if month > 1
        {
            return "\(month)m"
        }
        else if day > 1
        {
            return "\(day)days"
        }
        else if hours > 1
        {
            return "\(hours)h"
        }
        else if minutes > 1
        {
            return "\(minutes)m"
        }
        else
        {
            return "\(seconds)s"
        }    
        
    }
    
    func secondstohoursminsec(seconds: Int) -> (Int, Int, Int, Int, Int, Int)
    {
       return (seconds / 31536000, seconds / 2628000, seconds / (3600 * 24), seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    

}