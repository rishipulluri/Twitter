//
//  ProfileImageViewController.swift
//  TwitterKit
//
//  Created by saritha on 2/20/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit

class ProfileImageViewController: UIViewController {

    @IBOutlet var headerImage: UIImageView!
    @IBOutlet var handleLabel: UILabel!
    @IBOutlet var TiltleLabel: UILabel!
    @IBOutlet var imageLabel1: UIImageView!
    @IBOutlet var tweetsLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    @IBOutlet var followinglabel: UILabel!
    var tweet:Tweet!
    var user:User!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImage.setImageWithURL(NSURL(string: tweet.user.headerImageUrl!)!)
        TiltleLabel.text = tweet.user.Name!
        
        imageLabel1.setImageWithURL(NSURL(string: tweet.user.profileImageUrl!)!)

        
        tweetsLabel.text = "\(tweet.user.tweetCount!)"
        followinglabel.text = "\(tweet.user.followingCount!)"
        followersLabel.text = "\(tweet.user.followerCount!)"
        handleLabel.text = tweet.user.tagline
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
