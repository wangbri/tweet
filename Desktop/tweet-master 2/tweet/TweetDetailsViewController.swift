//
//  TweetDetailsViewController.swift
//  tweet
//
//  Created by Brian Wang on 2/27/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweet: Tweet!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(tweet)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = .MediumStyle
        tweet.createdAt = dateFormatter.stringFromDate(tweet.tempDate!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func onBack(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    /*@IBAction func onRetweet(sender: AnyObject) {
        
        //retweet-action-on-green
        let tweet = self.tweet
        let tweetID = tweet.tweetID
        
        TwitterClient.sharedInstance.retweetItem(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                self.tweet.retweetCount = self.tweet.retweetCount as! Int + 1
            }
        }
        
    }*/
    
    /*@IBAction func onLike(sender: AnyObject) {
        
        //like-action-on-red
        let tweet = self.tweet
        let tweetID = tweet.tweetID
        
        TwitterClient.sharedInstance.likeItem(["id": tweetID!]) { (tweet, error) -> () in
            if (tweet != nil) {
                self.tweet.likeCount = self.tweet.likeCount as! Int + 1
            }
        }
        
    }*/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = self.tweet
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
