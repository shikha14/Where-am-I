//
//  ViewController.swift
//  Where am I
//
//  Created by Shikha Gupta on 10/11/16.
//  Copyright © 2016 shikha. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    
    @IBOutlet weak var latituteLabel: UILabel!
    
    @IBOutlet weak var longituteLabel: UILabel!
    
    @IBOutlet weak var altituteLabel: UILabel!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation : CLLocation = locations[0]
        
        self.latituteLabel.text="\(userLocation.coordinate.latitude)"
        self.longituteLabel.text="\(userLocation.coordinate.longitude)"
        self.courseLabel.text="\(userLocation.course)"
        self.speedLabel.text="\(userLocation.speed)"
         self.altituteLabel.text="\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil{
                print("Reverse geocoder failed with error :" + error!.localizedDescription)
                return
            }
            
            if placemarks?.count > 0
            {
                let place = placemarks![0] as! CLPlacemark
                var address  : String = ""
                
                if place.thoroughfare != nil
                {
                    address = address + place.thoroughfare!
                }
                
                if place.subLocality != nil
                {
                    address = address + "\n" + place.subLocality!
                }
                if place.subAdministrativeArea != nil
                {
                    address = address + "\n" + place.subAdministrativeArea!
                }
                if place.postalCode != nil
                {
                    address = address + "\n" + place.postalCode!
                }
                if place.country != nil
                {
                    address = address + "\n" + place.country!
                }
                
                
                //print(place)
                self.addressLabel.text = "\(address)"
                
            }
            else{
                print("Problem with the data recived from geocoder")
            }
        }
        
        

        
    }
}

