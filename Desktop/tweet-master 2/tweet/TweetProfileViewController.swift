//
//  TweetProfileViewController.swift
//  tweet
//
//  Created by Brian Wang on 2/28/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit

class TweetProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?
    
    var tweet: Tweet?
    
    @IBOutlet weak var tweetsCount: UILabel!
    
    @IBOutlet weak var followersCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var profileBackImage2: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var screenLabel: UILabel!
    
    var profileURL: NSURL?
    
    var profileBackURL: NSURL?
    
    @IBOutlet weak var tableView: UITableView!
    
    var screenname: String?
    
    var username: String?
    
    var tweetCell: TweetCell?
    
    var tweetCount: NSNumber?
    
    var followerCount: NSNumber?
    
    var followinCount: NSNumber?
    
    
    
    
    
    
    
    
    @IBOutlet weak var profileBackImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.layer.borderWidth = 3.0
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImage.clipsToBounds = true
        
        self.profileImage.layer.cornerRadius = 10.0
        
        
        profileBackImage.setImageWithURL(profileBackURL!)
        
        screenLabel.text = screenname
        
        userLabel.text = username
        
        profileImage.setImageWithURL(profileURL!)
        
        profileBackImage2.setImageWithURL(profileBackURL!)
        
        var blurEffect = UIBlurEffect(style: .Light)
        
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = profileBackImage.bounds
        
        
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        
        vibrancyView.frame = profileBackImage.bounds
        
        
        
        blurView.contentView.addSubview(vibrancyView)
        

        profileBackImage.addSubview(blurView)
        
        tweetCount = NSNumber(integer: tweetCell!.tweetsCount!)
        
        followerCount = NSNumber(integer: tweetCell!.followersCount!)
        
        followinCount = NSNumber(integer: tweetCell!.followingCount!)
        
        
        
        
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        
        
        /*if(tweetCell!.followersCount >= 1000000){
            followersCount.text = formatter.stringFromNumber(followerCount!)
            formatter.usesSignificantDigits = true
            formatter.minimumSignificantDigits = 1
            formatter.maximumSignificantDigits = 3
            followerCount = formatter.numberFromString(followersCount.text!)
            
            
            print(followerCount)
            print("****************")
            
        }*/
        
        followersCount.text = formatter.stringFromNumber(followerCount!)
        
        tweetsCount.text = formatter.stringFromNumber(tweetCount!)
        
        
        
        followingCount.text = formatter.stringFromNumber(followinCount!)
        


        
        
        TwitterClient.sharedInstance.userTimelineWithParams(["screen_name": self.screenname!]) { (tweets, error) -> () in
            
            self.tweets = tweets
            
            self.tableView.dataSource = self
            self.tableView.delegate = self
            
            for tweet in self.tweets! {
                print(tweet.text)
                
                
                
                
            }
            self.tableView.reloadData()
            
            
            
        }
        
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        //use auto-layout constraint rules
        tableView.estimatedRowHeight = 120
        //prevents auto-layout from calculating all of the scroll height dimension at once
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        cell.retweetButton.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
        let tweet = self.tweet
        let tweetID = self.tweet!.tweetID
        TwitterClient.sharedInstance.retweetItem(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                self.tweet!.retweetCount = self.tweet!.retweetCount as! Int + 1
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func onLike(sender: AnyObject) {
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        let tweet = self.tweet
        let tweetID = self.tweet!.tweetID
        cell.likeButton.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
        
        TwitterClient.sharedInstance.likeItem(["id": tweetID!]) { (tweet, error) -> () in
            if (tweet != nil) {
                self.tweet!.likeCount = self.tweet!.likeCount as! Int + 1
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func onBack(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        
        self.presentViewController(vc, animated: true, completion: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
