//
//  ViewController2.swift
//  hungryyeti
//
//  Created by Sam Wang on 6/16/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit
import CoreLocation




//view controller for second view to grab random restaurant. Currently will load function with api request on viewdidload
//pass information from loaded from api to another function that displays what was grabbed 

//will there be an issue with speed? If so think about merging both view controllers to one and grabbing api information on button press from first view 

class randomRestaurant: UIViewController, CLLocationManagerDelegate {
    
    
    
    //Instantiate Variables from storyboard//
    ////////////////////////////////////
    //location manager for user location
    let locationManager:CLLocationManager = CLLocationManager()
    @IBOutlet weak var YelpImage: UIImageView!
    @IBOutlet weak var starIcons: UIImageView!
    //error message if location can't be grabbed
    @IBOutlet weak var errorMessage: UILabel!
    //if restaurant is not satisfiable, search again
    @IBOutlet weak var refreshSearch: UIButton!
    //if more information is need open on yelp's mobile website or app if available
    @IBOutlet weak var openOnYelp: UIButton!
    //loading icon in place between both view controllers
    @IBOutlet weak var loading: UIActivityIndicatorView! = nil
    var businesses: [Business]!
    ////////////////////////////////////
    ////////////////////////////////////
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start animating icon
        self.loading.startAnimating()
        
        //setup location info
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        //store location in location variable of type CLLocation
        var location:CLLocation = locations[locations.count-1] as! CLLocation
        
        //check for location accuracy and stop when accurate enough
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            println(location.coordinate)
            
        }
        let te = "Food"
        Business.searchByLocationRatingDistance(te, limit: 20, Lat: location.coordinate.latitude, Long: location.coordinate.longitude, sort: 0, categories: "restaurants", radius_filter: 2000, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            let name = businesses.first!.name!
            println(name)
//            for business in businesses {
//                println(business.name!)
//                println(business.address!)
//            }
        })
        
    }

    
    //method in case location grabbing fails
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        self.errorMessage.text = "Can't Find You"
    }
   
    

    
    
}

