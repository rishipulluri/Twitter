//
//  TweetsDetailedViewController.swift
//  TwitterKit
//
//  Created by saritha on 2/18/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit

class TweetsDetailedViewController: UIViewController {

    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var favCount: UILabel!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var favButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        var image = UIImage(named: "bird")
        self.navigationItem.titleView = UIImageView(image: image)
        imageLabel.text = tweet.text
        imageView2.setImageWithURL(NSURL(string: tweet.user.profileImageUrl!)!)
        likeCount.text = "\(tweet.favoriteCount!)"
        favCount.text = "\(tweet.retweetCount!)"
        if (bool1 == true)
        {
            favButton.setImage(UIImage(named: "newretweet"), forState: UIControlState.Normal)
        }
        
        if bool == true
        {
            likeButton.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    @IBAction func pressbut(sender: AnyObject) {
        
        TwitterClient.sharedInstance.likeTweetWithId(tweet.id) { (tweets, error) -> () in
            print("sicccc")
            
            
            
        }
        
        if (self.tweet.favoriteCount != nil && bool == false) {
            self.tweet.favoriteCount = self.tweet.favoriteCount! + 1
            likeButton.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
            NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
            bool = true
            
        }
    }
    
    @IBAction func retweetbut(sender: AnyObject) {
        
        TwitterClient.sharedInstance.retweeting(tweet.id) { (tweets, error) -> () in
            print("sicccc")
            
            
            
        }
        
        if (self.tweet.retweetCount != nil && bool1 == false) {
            self.tweet.retweetCount = self.tweet.retweetCount! + 1
            favButton.setImage(UIImage(named: "newretweet"), forState: UIControlState.Normal)


            NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
            bool1 = true
            
        }
        
        
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
