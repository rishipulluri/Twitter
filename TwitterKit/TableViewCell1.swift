//
//  TableViewCell1.swift
//  TwitterKit
//
//  Created by saritha on 2/15/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit



class TableViewCell1: UITableViewCell {

  

    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var TimeStamp: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView1: UIImageView!
    
    @IBOutlet var handleLable: UILabel!
    var tweet: Tweet!{
        didSet {
            
            imageView1.setImageWithURL(NSURL(string: tweet!.user.profileImageUrl!)!);
            descriptionLabel.text = tweet!.text!;
            TimeStamp.text = tweet!.getDifference()
            // cell.titleLable.text = tweets![indexPath.row].user.Name!;
            titleLabel.text = tweet!.user.Name!
            handleLable.text = tweet!.user.ScreenName
            
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
        
        
    }
    @IBAction func likebut(sender: AnyObject) {
        
        TwitterClient.sharedInstance.likeTweetWithId(tweet.id) { (tweets, error) -> () in
            print("success")
        }
    }
    
 
}
