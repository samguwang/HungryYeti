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
    
    
    
    //Upon successful Location services call, make query request to Yelp API, return JSON object and pass into
    //sucessfulAPICall() method to then display info. Potentially add new helper method to display information
    //for design purorses or do everything in succesfullAPICall()
    func callYelpAPI(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
    }
    
    //make a delegate method of CLLocationManager, call Yelp API method upon successful authentication and pass
    //in location in the form of a Cll object
    func getLocationCallYelpAPI(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        //store location in location variable of type CLLocation
        var location:CLLocation = locations[locations.count-1] as! CLLocation
        
        //check for location accuracy and stop when accurate enough
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            println(location.coordinate)
        
        callYelpAPI(location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        
    }
    
    //method in case location grabbing fails
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        self.errorMessage.text = "Can't Find You"
    }
   
    
//    //read in JSON object from Yelp API call from previous function. Pass on information to new function to
//    //display on application
//    func sucessfulAPICall(json: JSON){
//        
//        //upong sucessful API call, stop loading icon
//        self.loading.stopAnimating()
//        
//    }
    
    
}
}
