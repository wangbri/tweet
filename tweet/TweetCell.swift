//
//  TweetCell.swift
//  tweet
//
//  Created by Brian Wang on 2/20/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenname: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet: Tweet! {
        didSet {
                let createdAt = tweet.createdAt!
                timestamp.text = "\(createdAt)h"
                tweetText.text = tweet.text
                        
                    if let _ = tweet.user!.profileUrl {
                        
                        let userDict = tweet.user!
                            
                        profileImage.setImageWithURL(userDict.profileUrl!)
                        screenname.text = "@\(userDict.screenname!)"
                        username.text = userDict.name
                        print("user touched")
                            
                    }
            
            
            }
                    
    }
            
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
