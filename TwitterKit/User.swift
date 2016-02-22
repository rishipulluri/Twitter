//
//  User.swift
//  TwitterKit
//
//  Created by saritha on 2/14/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit
var _currentUser: User?
let currentUserKey = "key value"
let userDidLogInNotification = "UserDidLoginNotification"
let userDidLogoutNotification = "UserDidLogoutNotification"

class User: NSObject {
    
    var Name: String?
    var ScreenName : String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    var followerCount: Int?
    var followingCount: Int?
    var tweetCount : Int?
    var headerImageUrl: String?


    
    init(dictionary:NSDictionary)
    {
        self.dictionary = dictionary
        Name = dictionary["name"] as! String
        ScreenName = dictionary["screen_name"] as! String
        profileImageUrl = dictionary["profile_image_url"] as! String
        tagline = dictionary["description"] as! String
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        if dictionary["profile_banner_url"] != nil
        {
            headerImageUrl = dictionary["profile_banner_url"] as? String

        }


    
    }
    
    func logout() {
        User.currentUser = nil;
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken();
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil);
    }

    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData;
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions());
                            _currentUser = User(dictionary: dictionary as! NSDictionary);
                    } catch _ {
        
                }
            }
        }
        return _currentUser;
        }
        set(user) {
            _currentUser = user;
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions());
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey);
                } catch _ {
                    
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey);
            }
            NSUserDefaults.standardUserDefaults().synchronize();
        }
    }
}