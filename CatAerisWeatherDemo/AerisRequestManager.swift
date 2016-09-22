//
//  AerisRequestManager.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/5/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit
import Aeris

internal enum AerisRequestState {
  case ready, started, inProgress, completed
}

protocol AerisRequestManagerDelegate: class {
  func placesRequestDidFinish(_ place: AWFPlace)
  func placesRequestDidFailWithError(_ error: NSError)
  
  func forecastRequestDidFinish(_ forecast: AWFForecast, forPlace place: AWFPlace)
  func forecastRequestDidFailWithError(_ error: NSError)
}

internal class AerisRequestManager {
  internal var currentRequestState: AerisRequestState = .ready
  
  fileprivate var lastRequestedPlace: AWFPlace?
  fileprivate var lastRequestedForecastDictionary: [AWFPlace : AWFForecast] = [:]
  internal weak var delegate: AerisRequestManagerDelegate?
  
  // TODO: eventually, if the current location is not found, set it to this default
  internal var defaultPlace: AWFPlace = AWFPlace(city: "new york", state: "ny", country: "us")
  
  internal var observationLoader: AWFObservationsLoader = AWFObservationsLoader()
  internal var forecastLoader: AWFForecastsLoader = AWFForecastsLoader()
  internal var placeLoader: AWFPlacesLoader = AWFPlacesLoader()
  
  // singleton
  internal static let shared: AerisRequestManager = AerisRequestManager()
  fileprivate init () {
  }
  
  internal func beginPlaceRequestForCoordinates(_ coordinates: CLLocationCoordinate2D) {
    let tempPlaceHolder: AWFPlace = AWFPlace(coordinate: coordinates)
    self.placeLoader.getPlace(tempPlaceHolder, options: AWFRequestOptions()) { (places, error) in
      
      if (places?.count)! > 0 {
        if let validPlace: AWFPlace = places?.first as? AWFPlace {
          self.lastRequestedPlace = validPlace
          self.delegate?.placesRequestDidFinish(self.lastRequestedPlace!)
        }
      }
      else {
        if error != nil {
          self.delegate?.placesRequestDidFailWithError(error as! NSError)
        }
      }
    }
  }
  
  internal func beginForecastRequestForPlace(_ place: AWFPlace) {
    let requestOptions: AWFRequestOptions = AWFRequestOptions()
    requestOptions.periodLimit = 10
    requestOptions.fromDate = Date()
    
    self.forecastLoader.getForecastFor(place, options: requestOptions) { (forecast, error) in
      
      if (forecast?.count)! > 0 {
        if let forecast: AWFForecast = forecast?.first as? AWFForecast {
          self.delegate?.forecastRequestDidFinish(forecast, forPlace: place)
          self.lastRequestedForecastDictionary[place] = forecast
        }
      }
      else {
        if error != nil {
          self.delegate?.forecastRequestDidFailWithError(error as! NSError)
        }
      }
    }
  }
  
  
}
