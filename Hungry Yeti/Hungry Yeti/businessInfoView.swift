//
//  ViewController.swift
//  Hungry Yeti
//
//  Created by Sam Wang on 6/14/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class businessInfoView: UIViewController, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var businessName: UILabel!
   
    @IBOutlet weak var numReviews: UILabel!
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var businessCategories: UILabel!
    
    @IBOutlet weak var bottomAddress: UILabel!
    var businesses: [Business]!
    
    var businessurl: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup userlocation settings
        self.loading.startAnimating()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        println("starting view controller2")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openYelp(sender: AnyObject) {
        if(UIApplication.sharedApplication().canOpenURL(businessurl)){
            UIApplication.sharedApplication().openURL(businessurl)
        }
    }
    
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    //after grabbing a business, display information
    func updateInfo(selected: Business, coord: CLLocationCoordinate2D){
        let name = selected.name!
        businessName.text = name
        let num = selected.reviewCount!
        let str = "\(num)" + " Reviews"
        println(str)
        numReviews.text = str
        businessCategories.text = selected.categories!
        
        let splitAdd = selected.address!.componentsSeparatedByString(", ")
        address.text = splitAdd[0]
        bottomAddress.text = splitAdd[1]
        businessurl = selected.mobileUrl
        println("calling updateinfo")
        println(selected.categories)
        
        //mapkit setup
        var span = MKCoordinateSpanMake(0.01, 0.01)
        var region = MKCoordinateRegion(center: coord, span: span)
        map.setRegion(region, animated: true)
        var annotation = MKPointAnnotation()
        annotation.coordinate = coord
        annotation.title = name
        map.addAnnotation(annotation)
        let data = NSData(contentsOfURL: selected.ratingImageURL!)
        starImage.image = UIImage(data: data!)
        self.loading.hidden = true
        self.loading.stopAnimating()
        
        
    }
    
    //function used to call make API request to Yelp servers
    func callAPI(cord: CLLocation){
        let te = "Food"
        Business.searchByLocationRatingDistance(te, limit: 20, Lat: cord.coordinate.latitude, Long: cord.coordinate.longitude, sort: 0, categories: "restaurants", radius_filter: 2000, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            println("calling callAPI function")
            let top = businesses.endIndex
            let ran = self.randRange(0, upper: 19)
            var selectedBusiness = businesses[ran]
            let businame = selectedBusiness.name!
            println(businame)
            println(selectedBusiness.ratingImageURL)
            self.updateInfo(selectedBusiness, coord: cord.coordinate)
        })
    }
    
    func passonLocation(loc: CLLocation){
        println("calling passonlocation")
        callAPI(loc)
    }
    
    //locationmanager delegate function from CLLocationManager, called when user location updated
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var i = 0
        println("callign locationmanager")
        println(locations[0])
        //store location in location variable of type CLLocation
        var location:CLLocation = locations[locations.count-1] as! CLLocation
        
        //check for location accuracy and stop when accurate enough
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            println(location.coordinate.latitude)
            println(location.coordinate.longitude)
            
        }
        println(location.timestamp)
        if(i == 0){
        passonLocation(location)
        }
        
        ++i
        println(i)
        
    }
    
    //locationManager delegate function if failure
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    
    
    
    
    
    
}

