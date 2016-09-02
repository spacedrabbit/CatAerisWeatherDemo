//
//  LocationManager.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/2/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

internal enum LocationHelperStatus {
  case Ready, NotReady, Denied
}

protocol LocationHelperDelegate: class {
  func authorizationStatusDidChange(status: LocationHelperStatus)
  func trackedLocationDidChange(location: CLLocation)
  func alertRequiresDisplay(alert: UIAlertController)
}

internal class LocationHelper: NSObject, CLLocationManagerDelegate {
  internal var locationManager: CLLocationManager = CLLocationManager()
  internal var trackedLocation: CLLocation? {
    willSet {
     self.delegate?.trackedLocationDidChange(newValue!)
    }
  }
  internal weak var delegate: LocationHelperDelegate?

  
  // singleton-ish, owning classes should keep a reference to LocationHelper.manager
  internal static var manager: LocationHelper = LocationHelper()
  override private init() {
    super.init()

    self.locationManager.delegate = self
    self.locationManager.pausesLocationUpdatesAutomatically = true
    self.locationManager.desiredAccuracy = 100.0 // in meters
    self.locationManager.distanceFilter = 50.0 // in meters
    
    self.checkAuthStatusAndRequestIfNeeded()
  }
  
  func checkAuthStatusAndRequestIfNeeded() {
    if CLLocationManager.authorizationStatus() == .NotDetermined {
      self.locationManager.requestAlwaysAuthorization()
    }
    else {
      self.locationManager.startUpdatingLocation()
    }
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    var delegateStatus: LocationHelperStatus
    switch status {
    case .AuthorizedAlways, .AuthorizedWhenInUse:
      delegateStatus = .Ready
      self.locationManager.startUpdatingLocation()
    case .NotDetermined:
      delegateStatus = .NotReady
      print("undetermined status")
    case .Denied, .Restricted:
      delegateStatus = .Denied
      let alert = UIAlertController(title: "Weather Services Unavailable",
                                    message: "It appears as though location services are not enabled for this app. Check your settings and try again",
                                    preferredStyle: .Alert)
      let alertOption: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
      alert.addAction(alertOption)
      self.delegate?.alertRequiresDisplay(alert)
    }
    
    self.delegate?.authorizationStatusDidChange(delegateStatus)
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let validLocation: CLLocation = locations.first {
      if let trackingLocation: CLLocation = self.trackedLocation {
        // if a tracked location exist, check that it's not already the same
        if trackingLocation != validLocation {
          self.trackedLocation = validLocation // update if it is different
        }
      }
      else {
        self.trackedLocation = validLocation
      }
    }
  }
  
}