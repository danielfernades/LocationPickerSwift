//
//  ViewController.swift
//  LocationpickerSwift
//
//  Created by Dan Rudolf on 7/10/14.
//  Copyright (c) 2014 com.rudolfmedia. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
                            

    @IBOutlet var mapview: MKMapView
    @IBOutlet var setButton: UIButton
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton.layer.cornerRadius = 5

        // add pinimage to mapview **Image data is bugprone and wont run on earlier than iOS8
        let pinImage: UIImageView = UIImageView(image: UIImage(named:"pin1"))
        pinImage.center = (CGPointMake(self.view.center.x, self.view.center.y - pinImage.frame.height))
        self.mapview.delegate = self
        self.mapview.addSubview(pinImage)

        locationManager = CLLocationManager()
        locationManager.delegate = self

        //New to iOS 8 - must specifiy permission type "all time" or "per use" ** plist also needs updated **
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()

    }

    @IBAction func onSetButtonPressed(sender: UIButton) {

        var currentLocation = mapview.centerCoordinate
        NSLog("Lon: \(currentLocation.longitude.description) Lat: \(currentLocation.latitude.description)")

    }

    //MapView Delegate

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){

        NSLog(error.description)
    }

     func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

        for location in locations{

            if location.horizontalAccuracy < 150 && location.verticalAccuracy < 150 {
                manager.stopUpdatingLocation()
                self.setMapViewCenter()
                NSLog(location.description)
                break
            }
        }
    }

    func setMapViewCenter(){

       var zoomRegion = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate, 500, 500)
        mapview.setRegion(zoomRegion, animated:true)
    }

}