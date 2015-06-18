//
//  ViewController2.swift
//  hungryyeti
//
//  Created by Sam Wang on 6/16/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit
import "YelpAPI.h"

//view controller for second view to grab random restaurant. Currently will load function with api request on viewdidload
//pass information from loaded from api to another function that displays what was grabbed 

//will there be an issue with speed? If so think about merging both view controllers to one and grabbing api information on button press from first view 

class ViewController2: UIViewController, CLLocationManagerDelegate {
    
    //location manager for user location
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var YelpImage: UIImageView!
    
    @IBOutlet weak var starIcons: UIImageView!
    
    //if restaurant is not satisfiable, search again
    @IBOutlet weak var refreshSearch: UIButton!
    
    //if more information is need open on yelp's mobile website or app if available
    
    @IBOutlet weak var openOnYelp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setup location info
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        YelpAPI();
        queryAPI();
        displayInfo();
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //authenticate Yelp API request
    func YelpAPI() {
        
    }
    
    get query
    func queryAPI() {
        
    }
    
    func displayInfo() {
        
    }
    
    
}
