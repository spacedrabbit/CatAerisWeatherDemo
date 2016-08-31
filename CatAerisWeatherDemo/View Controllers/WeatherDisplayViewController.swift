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
  
  internal var currentPlace: AWFPlace?
  internal var defaultPlace: AWFPlace = AWFPlace(city: "new york", state: "ny", country: "us")
  internal var observationLoader: AWFObservationsLoader = AWFObservationsLoader()
  internal var locationManager: CLLocationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.blueColor()
    self.locationManager.delegate = self
    
    self.checkLocationAuthorization()
    self.updateViews()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(containerView)
  }
  
  
  // MARK: - Location Setup/Retrieval
  func checkLocationAuthorization() {
    if CLLocationManager.authorizationStatus() == .NotDetermined {
      self.locationManager.requestAlwaysAuthorization()
    }
    else {
      self.locationManager.startUpdatingLocation()
    }
  }
  
  func updateViews() {
    
    if let validLocation: CLLocation = self.locationManager.location {
      self.currentPlace = AWFPlace(coordinate: validLocation.coordinate)
      if let validCurrentPlace = self.currentPlace {
        self.observationLoader.getObservationForPlace(validCurrentPlace, options: AWFRequestOptions(), completion: { (observations, error) in
          
          if let validObservation: AWFObservation = observations.first as? AWFObservation {
            
          }
          else {
            print("An error occured attempting to retrieve observation data from AWFObservationLoader\n\(error)")
          }
          
          
        })
      }
    }
    
  }
  
  // MARK: - CLLocationManagerDelegate
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
    switch status {
    case .AuthorizedAlways, .AuthorizedWhenInUse:
      self.locationManager.startUpdatingLocation()
    case .NotDetermined:
      print("undetermined status")
    case .Denied, .Restricted:
      let alert = UIAlertController(title: "Weather Services Unavailable", message: "It appears as though location services are not enabled for this app. Check your settings and try again", preferredStyle: .Alert)
      self.showViewController(alert, sender: self)
    }
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("locations updated")
    
  }
  
  
  // MARK: - Lazy Init
  internal lazy var containerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.blueColor()
    return view
  }()
  
}
