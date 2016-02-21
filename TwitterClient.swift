//
//  TwitterClient.swift
//  TwitterKit
//
//  Created by saritha on 2/14/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "TIMZ0KdqnAdaj7f6Wd7G0posQ";
let twitterConsumerSecret = "l8wOPzJVKQH8lcZe0AznVt8tXNInNeRQiRO1LuzzQWmqZMn6uI"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    
    var tweet:Tweet!
    
    var loginCompletion : ((user: User?, error: NSError?) -> ())?
    class var sharedInstance: TwitterClient{
        struct Static {
            
            static let instance =         TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

            
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary]);
            
            completion(tweets: tweets, error: nil);
            
            }, failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                print("error getting home timeline");
                completion(tweets: nil, error: error)
        });
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ())
    {
         loginCompletion = completion
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            print("got the access token")
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error:NSError!) -> Void in
                print("Error in getting access token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }

        
        
        
    }
    
    
    
    func likeTweetWithId(id: AnyObject?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json?id=\(id!)", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("success liking")
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error liking\(id)")
        })
        
    }
    
    func retweeting(id: AnyObject?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id!).json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("near success")
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error liking\(id)")
        })
    }
    
    func makeTweet(message: String) {
        "https://api.twitter.com/1.1/statuses/update.json?status=asdasdas%20ad&in_reply_to_status_id=701285744904642560"        
        POST("https://api.twitter.com/1.1/statuses/update.json?\(message)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully posted")
            print(response)
            print("https://api.twitter.com/1.1/statuses/update.json?\(message)")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to post")
        }
    }

    
    
    func openURL(url:NSURL)
    {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("got the request token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
                //print("user:\(response)")
                self.loginCompletion?(user: nil, error: nil)
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.Name)")
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)

            })
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
                //print("home_timeline:\(response)")
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets
                {
                    //print("text:\(tweet.text), created: \(tweet.createdAt)")
                }
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error getting home timeline")
            })
            }) { (error: NSError!) -> Void in
                print("Failed to recieve accessToken")
                self.loginCompletion?(user: nil, error: error)

        }
  
    }

    
    
        
    

}
//status=\(message)