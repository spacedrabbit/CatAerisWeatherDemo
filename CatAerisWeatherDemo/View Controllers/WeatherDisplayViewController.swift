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
  
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.view.backgroundColor = AppColors.DarkBackground
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
    self.containerView.snp_makeConstraints { (make) in
      make.top.equalTo(self.view).offset(AppLayout.StandardMargin + AppLayout.StatusBar)
      make.left.equalTo(self.view).offset(AppLayout.StandardMargin)
      make.bottom.right.equalTo(self.view).inset(AppLayout.StandardMargin)
    }
    
    self.locationLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.containerView).offset(AppLayout.StandardMargin).multipliedBy(4.0)
      make.centerX.equalTo(self.containerView)
    }
    
    self.weatherIconImageView.snp_makeConstraints { (make) in
      make.top.equalTo(self.locationLabel.snp_bottom).offset(AppLayout.StandardMargin)
      make.centerX.equalTo(self.locationLabel)
      make.size.equalTo(CGSize(width: 128.0, height: 128.0))
    }
    
    self.currentTempLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.weatherIconImageView.snp_bottom).offset(AppLayout.StandardMargin)
      make.centerX.equalTo(self.containerView)
    }
    
    self.weatherDescriptionLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.currentTempLabel.snp_bottom).offset(AppLayout.StandardMargin)
      make.centerX.equalTo(self.containerView)
    }
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(containerView)
    
    self.containerView.addSubview(locationLabel)
    self.containerView.addSubview(currentTempLabel)
    self.containerView.addSubview(weatherDescriptionLabel)
    self.containerView.addSubview(weatherIconImageView)
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

    // lots of messy nested functions, would split this out considerably
    if let validLocation: CLLocation = self.locationManager.location {
      self.currentPlace = AWFPlace(coordinate: validLocation.coordinate)
      if let validCurrentPlace = self.currentPlace {
        self.observationLoader.getObservationForPlace(validCurrentPlace, options: AWFRequestOptions(), completion: { (observations, error) in
          
          if let validObservation: AWFObservation = observations.first as? AWFObservation {
            if let parsedWeather = WeatherCodeParser.parseWeatherCode(validObservation.weatherCoded) {
              
              // I know that the weather component is the only one that is returning a valid value, so I'm just going to display that
              dispatch_async(dispatch_get_main_queue(), { 
                self.weatherDescriptionLabel.text = parsedWeather.weather!
                self.currentTempLabel.text = "\(validObservation.heatindexF)"
                self.locationLabel.text = validObservation.place.name
              })
            }
          }
          else {
            // veeeeery light error checking...
            print("An error occured attempting to retrieve observation data from AWFObservationLoader\n\(error)")
          }
          
        })
      }
    }
    
  }
  
  // MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    switch status {
    case .AuthorizedAlways, .AuthorizedWhenInUse:
      self.locationManager.startUpdatingLocation()
    case .NotDetermined:
      print("undetermined status")
    case .Denied, .Restricted:
      let alert = UIAlertController(title: "Weather Services Unavailable", message: "It appears as though location services are not enabled for this app. Check your settings and try again", preferredStyle: .Alert)
      let alertOption: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
      alert.addAction(alertOption)
      self.showViewController(alert, sender: self)
    }
  }
  
  
  // MARK: - Lazy Init
  internal lazy var containerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = AppColors.StandardBackground
    return view
  }()
  
  internal lazy var weatherDescriptionLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = ""
    label.font = AppFont.StandardFont
    label.textColor = AppColors.StandardTextColor
    return label
  }()
  
  internal lazy var locationLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "Loading..."
    label.font = AppFont.StandardFont
    label.textColor = AppColors.StandardTextColor
    return label
  }()
  
  internal lazy var currentTempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = ""
    label.font = AppFont.StandardFont
    label.textColor = AppColors.StandardTextColor
    return label
  }()
  
  internal lazy var weatherIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "cloudy"))
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
}

