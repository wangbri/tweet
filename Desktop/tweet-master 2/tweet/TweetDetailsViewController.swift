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
    
    var tweetCell: TweetCell?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var replyField: UITextField!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var screenname: String?
    
    @IBOutlet weak var charCount: UILabel!
    
    
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
        
        replyField.text = "@\(screenname!)"
        replyField.textColor = UIColor.lightGrayColor()
        
        let count = replyField.text?.characters.count
        charCount.text = "\(140-count!)"
        
        self.replyField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(textField: UITextField){
        if replyField.textColor == UIColor.lightGrayColor() {
            replyField.textColor = UIColor.blackColor()
            
        }
        let count = textField.text?.characters.count
        charCount.text = "\(140-count!)"
    }
    
    
    
    @IBAction func onBack(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        let tweet = self.tweet
        let tweetID = tweet.tweetID
        cell.retweetButton.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
        TwitterClient.sharedInstance.retweetItem(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                self.tweet.retweetCount = self.tweet.retweetCount as! Int + 1
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
        let tweetID = tweet.tweetID
        cell.likeButton.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
        
        TwitterClient.sharedInstance.likeItem(["id": tweetID!]) { (tweet, error) -> () in
            if (tweet != nil) {
                self.tweet.likeCount = self.tweet.likeCount as! Int + 1
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadData()
            }
        }
        
    }
    @IBAction func onReply(sender: AnyObject) {
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        let tweet = self.tweet
        let tweetID = tweet.tweetID
        cell.replyButton.setImage(UIImage(named: "reply-action-pressed_0"), forState: UIControlState.Normal)
        
        print("REPLYPRESSED")
        
        TwitterClient.sharedInstance.replyItem(replyField.text, params: tweetID)
        
        replyField.text = "@\(screenname!)"
        replyField.textColor = UIColor.lightGrayColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = self.tweet
        
        tweetCell = cell
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
