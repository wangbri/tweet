//
//  ViewController.swift
//  tweet
//
//  Created by Brian Wang on 2/15/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil {
                //perform segue if login successful
                
                self.performSegueWithIdentifier("loginSegue", sender: self)
                //because the closure can be saved, can immediately specify
            } else {
                //handle login error
            }
        }
        
    }
        
        
        
        
        

}

