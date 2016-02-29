//
//  ComposeTweetViewController.swift
//  tweet
//
//  Created by Brian Wang on 2/28/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import AFNetworking

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var username: UILabel!

    @IBOutlet weak var screenname: UILabel!
    
    @IBOutlet weak var profileView: UIImageView!
    
    @IBOutlet weak var tweetField: UITextField!
    
    @IBOutlet weak var charCount: UILabel!
    
    var screennamee: String?
    
    var usernamee: String?
    
    var profileUrl: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.setImageWithURL(profileUrl!)
        
        username.text = usernamee
        screenname.text = "@\(screennamee!)"
        
        let count = tweetField.text?.characters.count
        charCount.text = "\(140-count!)"
        
        self.tweetField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onBack(sender: AnyObject) {
            
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidChange(textField: UITextField) {
        //your code
        let count = textField.text?.characters.count
        charCount.text = "..\(140-count!)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.composeItem(tweetField.text)
        self.dismissViewControllerAnimated(true, completion: nil)
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
