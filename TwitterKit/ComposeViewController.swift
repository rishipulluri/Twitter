//
//  ComposeViewController.swift
//  TwitterKit
//
//  Created by saritha on 2/19/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var titleLabel1: UILabel!
    @IBOutlet var handleLabel1: UILabel!
    @IBOutlet var TextView1: UITextView!
    @IBOutlet var ImageView3: UIImageView!
    @IBOutlet var charcount: UILabel!
    var chractercount:Bool = true
    var tweet: Tweet!
    var newUser:User!
    var reply_id:String?
    var post: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = UIImage(named: "bird.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        titleLabel1.text = User.currentUser?.Name
        ImageView3.setImageWithURL(NSURL(string: (User.currentUser?.profileImageUrl)!)!)
            handleLabel1.text = User.currentUser?.ScreenName

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonAction(sender: AnyObject) {
        
        if (chractercount == false)
        {
            let alertController = UIAlertController(title: "iOScreator", message:
                "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            
            var messageToSend = "status=" + TextView1.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            print(reply_id)
            if (reply_id != nil)
            {
                messageToSend =  messageToSend + "&in_reply_to_status_id=\(reply_id!)"
            }
            print(messageToSend)
            
            
            TwitterClient.sharedInstance.makeTweet(messageToSend)
        }
        
        
        
    }
    
    public func textViewDidChange(textView: UITextView)
    {
        let temp = TextView1.text
        let numTemp = temp?.characters.count
        charcount.text = "\(140 - numTemp!)"
        if (Int(charcount.text!)! <= 0)
        {
            chractercount = false;
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
