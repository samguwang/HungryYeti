//
//  Business.swift
//  hungryyeti
//
//  Created by Sam.Wang2 on 6/22/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit
import CoreLocation



class Business: NSObject {
    
    //Variables to unwrap JSON object for business fields
    let name: String?
    let address: String?
    let imageURL: NSURL?
    let categories: String?
    let distance: String?
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    

    //initialize a dictionary data structure to store different fields with respective data types
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        //imageURL
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = NSURL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        //address
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            var street: String? = ""
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            var neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        
        //categories
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                var categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = ", ".join(categoryNames)
        } else {
            categories = nil
        }
        
        
        //distance from userlocation
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        
        //link to Yelp star rating url
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = NSURL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    //function create dictionary of businesses
    class func businesses(#array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            var business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    
    //shared function to make Yelp API request
    class func searchByLocationRatingDistance(term: String, limit: Int, Lat: CLLocationDegrees, Long: CLLocationDegrees, sort: Int, categories: String, radius_filter: Int,
        completion: ([Business]!, NSError!) -> Void) {
            yelpAPIClient.sharedInstance.searchByLocationRatingDistance(term, limit: limit, Lat: Lat, Long: Long, sort: sort, categories: categories, radius_filter: radius_filter, completion:completion)
    }
    
    
}