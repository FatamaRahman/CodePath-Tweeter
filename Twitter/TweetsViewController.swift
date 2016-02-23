//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Fatama on 2/20/16.
//  Copyright © 2016 Fatama Rahman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        let retweetButton = sender as! UIButton
        let tweetId = retweetButton.titleLabel!.text
        TwitterClient.sharedInstance.retweet(tweetId!)
        let view = retweetButton.superview!
        let cell = view.superview as! TweetCell
        
        cell.retweetCountLabel.text = String(Int(cell.retweetCountLabel.text!)!+1)
    
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        let favoriteButton = sender as! UIButton
        let tweetId = favoriteButton.titleLabel!.text
        
        TwitterClient.sharedInstance.favorite(tweetId!)
        
        let view = favoriteButton.superview!
        let cell = view.superview as! TweetCell
        
        cell.favoriteCountLabel.text = String(Int(cell.favoriteCountLabel.text!)!+1)

    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let tweetInfo = tweets![indexPath.row]
        cell.profileImageView.setImageWithURL(NSURL(string: (tweetInfo.user?.profileImageUrl)!)!)
        cell.nameLabel.text = tweetInfo.user?.name
        cell.screenNameLabel.text = "@" + (tweetInfo.user?.screenname)!
        cell.createdAtLabel.text = tweetInfo.createdAtString
        cell.tweetTextLabel.text = tweetInfo.text
        cell.retweetCountLabel.text = tweetInfo.retweetCount!
        cell.favoriteCountLabel.text = tweetInfo.favoriteCount!
        cell.tweetId = tweetInfo.tweetId
        cell.reTweetButton.setTitle(tweetInfo.tweetId, forState: .Normal)
        cell.favoriteButton.setTitle(tweetInfo.tweetId, forState: .Normal)
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    
        
    }
    
    
}
