//
//  TweetsViewController.swift
//  tweet
//
//  Created by Brian Wang on 2/19/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    //var tweet: TweetCell?
    
    var segueCell: TweetCell?
    
    var currentUser: User?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.getStatus(nil, completion: {(returns, error) -> () in
            print(returns)
            print(error)
        })
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
        // Do any additional setup after loading the view.
            self.tweets = tweets
            //reload tableview as well
            //tweet.favorite, will do a POST instead of GET
            
            self.tableView.dataSource = self
            self.tableView.delegate = self
            
            //for tweet in self.tweets! {
                //print(tweet.text)
            //}
            self.tableView.reloadData()
        })
        
        
        
        
        
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        //use auto-layout constraint rules
        tableView.estimatedRowHeight = 120
        //prevents auto-layout from calculating all of the scroll height dimension at once
        
    }
    
    @IBAction func onCompose(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("composeView") as! ComposeTweetViewController
        
        //vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        print(User.currentUser?.screenname)
        
        vc.screennamee = User.currentUser?.screenname
        
        vc.usernamee = User.currentUser?.name
        
        vc.profileUrl = User.currentUser?.profileUrl
        
        print(User.currentUser?.profileUrl)
        
        
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        
    }
    @IBAction func onRetweet(sender: AnyObject) {
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        cell.retweetButton.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
        let tweet = tweets![indexPath.row]
        let tweetID = tweet.tweetID
        TwitterClient.sharedInstance.retweetItem(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                self.tweets![indexPath.row].retweetCount = self.tweets![indexPath.row].retweetCount as! Int + 1
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func onLike(sender: AnyObject) {
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        let tweet = tweets![indexPath.row]
        let tweetID = tweet.tweetID
        cell.likeButton.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)

        TwitterClient.sharedInstance.likeItem(["id": tweetID!]) { (tweet, error) -> () in
            if (tweet != nil) {
                self.tweets![indexPath.row].likeCount = self.tweets![indexPath.row].likeCount as! Int + 1
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = self.tweets![indexPath.row]
        
        

        return cell
    }
    
    @IBAction func onProfile(sender: AnyObject) {
        
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("profileView") as! TweetProfileViewController
        
        vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        vc.screenname = cell.screenname.text
        
        vc.username = cell.username.text
        
        vc.profileURL = cell.profileURL
        
        vc.profileBackURL = cell.profileBackURL
        
        vc.tweetCell = cell
        
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        segueCell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        self.segueCell!.tweet = self.tweets![indexPath.row]
        
        print("SELECTED")
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("detailsView") as! TweetDetailsViewController
        
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        let tweet = self.segueCell!.tweet
        
        vc.tweet = tweet
        
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("SEGUE")
        let tweet = self.segueCell!.tweet
        
        let detailViewController = segue.destinationViewController as! TweetDetailsViewController
        detailViewController.tweet = tweet
        
        
    }*/

    

}
