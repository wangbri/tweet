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
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
                let createdAt = tweet.createdAt!
                timestamp.text = createdAt
                tweetText.text = tweet.text
            
                likeLabel.text = "\(tweet.likeCount as! Int)"
                retweetLabel.text = "\(tweet.retweetCount as! Int)"
            
            
                        
                    if let _ = tweet.user!.profileUrl {
                        
                        let userDict = tweet.user!
                            
                        profileImage.setImageWithURL(userDict.profileUrl!)
                        screenname.text = "@\(userDict.screenname!)"
                        username.text = userDict.name
                        
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
