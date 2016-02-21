//
//  TweetsViewController.swift
//  TwitterKit
//
//  Created by saritha on 2/14/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        
        var image = UIImage(named: "bird")
        self.navigationItem.titleView = UIImageView(image: image)
                
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name:"refreshMyTableView", object: nil)
        callTwitterUpdateTweetsAPI()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        super.viewDidLoad()
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutb(sender: AnyObject) {
        User.currentUser!.logout();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tweets != nil{
            return tweets!.count
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("tablecell", forIndexPath: indexPath) as! TableViewCell1;
       // cell.imageView1.setImageWithURL(NSURL(string: tweets![indexPath.row].user.profileImageUrl!)!);
      //  cell.descriptionLabel.text = tweets![indexPath.row].text!;
    //    cell.TimeStamp.text = tweets![indexPath.row].getDifference()
       // cell.titleLable.text = tweets![indexPath.row].user.Name!;
      //  cell.titleLabel.text = tweets![indexPath.row].user.Name!
        cell.tweet = tweets![indexPath.row]
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailview" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let detailViewController = segue.destinationViewController as! TweetsDetailedViewController
            detailViewController.tweet = tweet
        }
        else if segue.identifier == "profilesegue" {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! UITableViewCell
            
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let detailViewController = segue.destinationViewController as!  ProfileImageViewController
            detailViewController.tweet = tweet
           
        }
        
       /**
        if segue.identifier == "composesegue"
        {
            let cell = sender as!
            let indexpath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexpath!.row]
           let detailviewController = segue.destinationViewController as! ComposeViewController
            detailviewController.tweet = tweet
            print("composed the view COntroller")
        }
*/
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func refreshList(notification: NSNotification){
        tableView.reloadData()
    }

    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
        
        callTwitterUpdateTweetsAPI()
        
        self.refreshControl?.endRefreshing()
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func callTwitterUpdateTweetsAPI() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
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
