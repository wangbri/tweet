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
    
    var profileUrl: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.setImageWithURL(profileUrl!)
        
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
