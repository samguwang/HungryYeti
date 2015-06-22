//
//  ViewController.swift
//  Hungry Yeti
//
//  Created by Sam Wang on 6/14/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit
import CoreLocation


class businessInfoView: UIViewController, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var businessName: UILabel!
   
    
    
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loading.startAnimating()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        println("starting")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    //after grabbing a business, display information
    func updateInfo(selected: Business){
        self.loading.hidden = true
        self.loading.startAnimating()
        let name = selected.name
        businessName.text = name
        
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
            let top = businesses.endIndex
            let ran = self.randRange(0, upper: 19)
            var selectedBusiness = businesses[ran]
            let businame = selectedBusiness.name
            println(businame)
            self.updateInfo(selectedBusiness)
            
        })
        
    }
    
    
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    
    
    
    
    
    
}

