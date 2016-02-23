//
//  Tweet.swift
//  Twitter
//
//  Created by Fatama on 2/18/16.
//  Copyright © 2016 Fatama Rahman. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var tweetId: String?
    var retweetCount: String?
    var favoriteCount: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        tweetId = dictionary["id_str"] as? String
        retweetCount = String(dictionary["retweet_count"] as! Int)
        favoriteCount = String(dictionary["favorite_count"] as! Int)
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Month, .Day, .Year], fromDate: createdAt!)
        createdAtString = "\(components.month)/\(components.day)/\(components.year%2000)"
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    

}
