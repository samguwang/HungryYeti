//
//  yelpAPIClient.swift
//  hungryyeti
//
//  Created by Sam.Wang2 on 6/22/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import Foundation
import CoreLocation



//YelpAPI access from API console
let yelpConsumerKey = "M3Z7FnwoTUPbhcl7O92bEw"
let yelpConsumerSecret = "YhehU_ik0zKB84c3r1g7VlaxhQ8"
let yelpToken = "VMKgIAyZFW2AF1CQ_GW_3qaCxsS3LHUj"
let yelpTokenSecret = "9dfGC-nfwaHYVaF493cg1xidJcU"




//incorporate BDBOAuth1Manager pod for authentication to Yelp API
class yelpAPIClient: BDBOAuth1RequestOperationManager{
    
    var accessToken: String!
    var accessSecret: String!
    
    class var sharedInstance : yelpAPIClient {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : yelpAPIClient? = nil
        }
        
        //used to nitialize accesstoken with init method including consumerkey, consumersecret, yelptoken, and yelptokensecret
        
        dispatch_once(&Static.token) {
            Static.instance = yelpAPIClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return Static.instance!
    }
    
    //initalize functions for yelpauthentication variables
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }

    
    
    
    //function to sent a request to YelpAPI for search
    func searchByLocationRatingDistance(term: String, limit: Int, Lat: CLLocationDegrees, Long: CLLocationDegrees, sort: Int, categories: String, radius_filter: Int,
        completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        
        let latlong = Lat.description + "," + Long.description
        var parameters: [String : AnyObject] = ["term": term, "limit": limit, "ll": latlong, "sort": sort, "category_filter": categories, "radius_filter":radius_filter]
        
            //return JSON request and unwrap using Buesiness class 
            return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var dictionaries = response["businesses"] as? [NSDictionary]
                if dictionaries != nil {
                    completion(Business.businesses(array: dictionaries!), nil)
                }
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    completion(nil, error)
            })
    }
    
    
   
}

    
