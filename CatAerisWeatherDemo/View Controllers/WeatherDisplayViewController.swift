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

class WeatherDisplayViewController: UIViewController, LocationHelperDelegate {
  
  internal var currentPlace: AWFPlace?
  // TODO: eventually, if the current location is not found, set it to this default
  internal var defaultPlace: AWFPlace = AWFPlace(city: "new york", state: "ny", country: "us")
  internal var observationLoader: AWFObservationsLoader = AWFObservationsLoader()
  internal var forecastLoader: AWFForecastsLoader = AWFForecastsLoader()
  
  private var trackedLocation: CLLocation?
  internal var locationHelper: LocationHelper = LocationHelper.manager
  
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.locationHelper.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    self.temperatureScaleIcon.snp_updateConstraints { (make) in
      make.height.equalTo(self.currentTempLabel.intrinsicContentSize().height * 0.80)
    }
  }
  
  // ---------------------------------------------------------------- //
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
    
    self.temperatureScaleIcon.snp_makeConstraints { (make) in
      make.left.equalTo(self.currentTempLabel.snp_right).inset(AppLayout.StandardMargin)
      make.centerY.equalTo(self.currentTempLabel)
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
    self.containerView.addSubview(temperatureScaleIcon)
    
    self.view.backgroundColor = AppColors.DarkBackground
    self.containerView.layer.cornerRadius = AppLayout.StandardMargin
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - UI Updates
  internal func updateUIElementsForObservation(observation: AWFObservation) {
    // TODO: make this parsing a lot better ffs
    if let parsedWeather = AerisCodeParser.parseWeatherCode(observation.weatherCoded) {
      
      // I know that the weather component is the only one that is returning a valid value, so I'm just going to display that
      dispatch_async(dispatch_get_main_queue(), {
        self.weatherDescriptionLabel.text = parsedWeather.weather!
        self.currentTempLabel.text = "\(observation.heatindexF)"
        self.locationLabel.text = observation.place.name
      })
    }
  }
  
  internal func updateUIElementsForForcast(forecast: AWFForecast) {
    
  }
  
  // ---------------------------------------------------------------- //
  // MARK: - LocationHelperDelegate
  func authorizationStatusDidChange(status: LocationHelperStatus) {
    // not entirely sure how I'm going to use this yet, but likely will be needed for something
    switch status {
    case .Ready:
      print("Location Status is Ready")
    case .NotReady:
      print("Location Status is Not Ready")
    case .Denied:
      print("Location Status is Denied")
    }
  }
  
  func alertRequiresDisplay(alert: UIAlertController) {
    self.showViewController(alert, sender: self)
  }
  
  func trackedLocationDidChange(location: CLLocation) {
    
    self.currentPlace = AWFPlace(coordinate: location.coordinate)
    
    self.forecastLoader.getForecastForPlace(self.currentPlace!, options: AWFRequestOptions()) { (forecasts, error) in
      if forecasts.count > 0 {
        if let forecast: AWFForecast = forecasts.first as? AWFForecast {
          // TODO: get data from forecast obj
          // TODO: work with .periods property (AWFPeriod) to populate data
        }
      }
    }
    
    
    self.observationLoader.getObservationForPlace(self.currentPlace!, options: AWFRequestOptions(), completion: { (observations, error) in
      if let validObservation: AWFObservation = observations.first as? AWFObservation {
        self.updateUIElementsForObservation(validObservation)
      }
      else {
        print("An error occured attempting to retrieve observation data from AWFObservationLoader\n\(error)")
        self.locationHelper.restartLocationService() // TODO: this needs testing and better  handling
      }
    })
    
  }
  
  // ---------------------------------------------------------------- //
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
  
  internal lazy var temperatureScaleIcon: UIImageView = {
    var imageView: UIImageView = UIImageView(image: UIImage(named: "far")?.imageWithRenderingMode(.AlwaysTemplate))
    imageView.tintColor = AppColors.StandardTextColor
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
}

