//
//  TweetsDetailedViewController.swift
//  TwitterKit
//
//  Created by saritha on 2/18/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit

class TweetsDetailedViewController: UIViewController {

    @IBOutlet var replyCount: UILabel!
    @IBOutlet var commandLabel: UILabel!
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var favCount: UILabel!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var favButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    var reply_id: String!
    
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
        TitleLabel.text = tweet.user.Name
        commandLabel.text = tweet.user.ScreenName

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
    
    
    @IBAction func ReplyButton(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tocomposefromdetail"
        {
            reply_id = tweet.id as! String 
            let lb = segue.destinationViewController as! ComposeViewController
            print(reply_id)
            lb.reply_id = reply_id
            var yodo = Int(replyCount.text!)
            replyCount.text = "\(yodo!  + 1) "
            
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
