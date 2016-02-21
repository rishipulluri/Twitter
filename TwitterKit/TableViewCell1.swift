//
//  TableViewCell1.swift
//  TwitterKit
//
//  Created by saritha on 2/15/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit


var bool:Bool = false
var bool1:Bool = false
class TableViewCell1: UITableViewCell {

  

    @IBOutlet var retweetbut: UIButton!
    @IBOutlet var likebut: UIButton!
    
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var retweetCount: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var TimeStamp: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView1: UIImageView!
    
    @IBOutlet var handleLable: UILabel!
    
    var newUser: User!
    var tweet: Tweet!{
        didSet {
            
            imageView1.setImageWithURL(NSURL(string: tweet!.user.profileImageUrl!)!);
            descriptionLabel.text = tweet!.text!;
            TimeStamp.text = tweet!.getDifference()
            // cell.titleLable.text = tweets![indexPath.row].user.Name!;
            titleLabel.text = tweet!.user.Name!
            handleLable.text = tweet!.user.ScreenName
            retweetCount.text = "\(tweet.retweetCount!)"
            likeCount.text = "\(tweet.favoriteCount!)"


            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweeting(tweet.id) { (tweets, error) -> () in
            print("sicccc")
            
            
            
        }
        if (retweetbut == "retweet-action-on-passed")
        {
            bool = false;
        }
        
        if (self.tweet.retweetCount != nil && bool == false) {
            self.tweet.retweetCount = self.tweet.retweetCount! + 1
            likebut.setImage(UIImage(named: "newretweet"), forState: UIControlState.Normal)
            NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
            bool = true
        
        }
        
       



        
        
    }
    @IBAction func likebut(sender: AnyObject) {
        
        TwitterClient.sharedInstance.likeTweetWithId(tweet.id) { (tweets, error) -> () in
            print("success")
         
           

        }
        if (likebut.currentImage == "onaction")
        {
            bool1 = false;
        }
        
        if (self.tweet.favoriteCount != nil && bool1 == false ) {
            self.tweet.favoriteCount = self.tweet.favoriteCount! + 1
            bool1 = true
             retweetbut.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
            NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
            
        }
        
       
      



    }
    
        
 
}
