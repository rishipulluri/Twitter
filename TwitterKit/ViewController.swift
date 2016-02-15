//
//  ViewController.swift
//  TwitterKit
//
//  Created by saritha on 2/9/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {
    
    let twitterConsumerKey = "TIMZ0KdqnAdaj7f6Wd7G0posQ";
    let twitterConsumerSecret = "l8wOPzJVKQH8lcZe0AznVt8tXNInNeRQiRO1LuzzQWmqZMn6uI"
    let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        
    }
    @IBAction func actionjackson(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion()
            {
                (user:User?, error: NSError?) in
                //if user != nil
               // {
                self.performSegueWithIdentifier("blo", sender: self)
                
               // else
//{
           //         print("nadahoe")
                //}
        }
    }
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

