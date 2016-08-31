//
//  WeatherDisplayViewController.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit
import Aeris

class WeatherDisplayViewController: UIViewController, CLLocationManagerDelegate {
  
  internal var currentPlace: AWFPlace!
  internal var observationLoader: AWFObservationsLoader!
  
  internal var locationManager: CLLocationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.blueColor()
    self.locationManager.delegate = self
    
    self.checkLocationAuthorization()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func checkLocationAuthorization() {
    if CLLocationManager.authorizationStatus() == .NotDetermined {
      self.locationManager.requestAlwaysAuthorization()
    }
    
  }
  
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("location service error")
  }
  
  func locationManagerDidResumeLocationUpdates(manager: CLLocationManager) {
    print("did resume location updates")
  }
  
  func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
    print("did start monitoring for region")
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    print("did change auth status")
    
    if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
      self.locationManager.startUpdatingLocation()
    }
    else if status == .NotDetermined {
      print("status undetermined")
    }
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("locations updated")
  }
}
