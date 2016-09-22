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
  case ready, notReady, denied
}

protocol LocationHelperDelegate: class {
  func authorizationStatusDidChange(_ status: LocationHelperStatus)
  func trackedLocationDidChange(_ location: CLLocation)
  func alertRequiresDisplay(_ alert: UIAlertController)
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
  override fileprivate init() {
    super.init()

    self.locationManager.delegate = self
    self.locationManager.pausesLocationUpdatesAutomatically = true
    self.locationManager.desiredAccuracy = 100.0 // in meters
    self.locationManager.distanceFilter = 50.0 // in meters
    
    self.checkAuthStatusAndRequestIfNeeded()
  }
  
  func checkAuthStatusAndRequestIfNeeded() {
    if CLLocationManager.authorizationStatus() == .notDetermined {
      self.locationManager.requestAlwaysAuthorization()
    }
    else {
      self.locationManager.startUpdatingLocation()
    }
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Helpers
  internal func restartLocationService() {
    self.locationManager.stopUpdatingLocation()
    self.locationManager.startUpdatingLocation()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - CLLocationManagerDelegate
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    var delegateStatus: LocationHelperStatus
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      delegateStatus = .ready
      self.locationManager.startUpdatingLocation()
    case .notDetermined:
      delegateStatus = .notReady
      print("undetermined status")
    case .denied, .restricted:
      delegateStatus = .denied
      let alert = UIAlertController(title: "Weather Services Unavailable",
                                    message: "It appears as though location services are not enabled for this app. Check your settings and try again",
                                    preferredStyle: .alert)
      let alertOption: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alert.addAction(alertOption)
      self.delegate?.alertRequiresDisplay(alert)
    }
    
    self.delegate?.authorizationStatusDidChange(delegateStatus)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let validLocation: CLLocation = locations.first {
      if let trackingLocation: CLLocation = self.trackedLocation {
        // if a tracked location exist, check that it's not already the same
        
        // Note: this delegate method can fire multiple times due to the precision of the lat/long changing slightly and rapidly
        // while the app first looks for it's current location. So, an arbitrary standard of 50.0 meters is used to compare the 
        // currently tracked location with the (potentially) slightly different location pass in subsequent calls to this method.
        if (trackingLocation != validLocation) &&
           (trackingLocation.distance(from: validLocation) > 50.0) {
          self.trackedLocation = validLocation // update if it is different
        }
      }
      else {
        self.trackedLocation = validLocation
      }
    }
  }
  
}
