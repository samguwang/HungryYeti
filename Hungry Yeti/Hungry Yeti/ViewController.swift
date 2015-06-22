//
//  ViewController.swift
//  Hungry Yeti
//
//  Created by Sam Wang on 6/14/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager:CLLocationManager = CLLocationManager()

    
    @IBOutlet weak var apiButton: UIButton!
    
    
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
//    func randRange (lower: Int , upper: Int) -> Int {
//        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
//    }
//    
//    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        
//        //store location in location variable of type CLLocation
//        var location:CLLocation = locations[locations.count-1] as! CLLocation
//        
//        //check for location accuracy and stop when accurate enough
//        if (location.horizontalAccuracy > 0) {
//            self.locationManager.stopUpdatingLocation()
//            println(location.coordinate)
//            
//        }
//        let te = "Food"
//        Business.searchByLocationRatingDistance(te, limit: 20, Lat: location.coordinate.latitude, Long: location.coordinate.longitude, sort: 0, categories: "restaurants", radius_filter: 2000, completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            let top = businesses.endIndex
//            let ran = self.randRange(0, upper: 19)
//            let businame = businesses[ran].name
//            println(businame)
////            for business in businesses {
////                println(business.name!)
////                println(business.address!)
////            }
//        })
//    
//    }
//    
//    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
//        println(error)
//    }
    
    
    
    



}

