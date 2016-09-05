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
  internal var placeLoader: AWFPlacesLoader = AWFPlacesLoader()
  
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
  internal func updateDailyHUD(period: AWFForecastPeriod) {
    self.weatherDescriptionLabel.text = period.weatherFull
    self.currentTempLabel.text = "\(period.avgTempF)"
    self.locationLabel.text = self.currentPlace!.formattedNameFull
  }
  
  internal func updateUIElementsForForcast(forecast: AWFForecast) {
    
    periodLoop: for period in forecast.periods as! [AWFForecastPeriod] {
      let dateHelper = DateConversionHelper(withDate: period.timestamp)
      if dateHelper.isTodaysDate() {
        self.updateDailyHUD(period)
        continue periodLoop
      }
//      print("use rest of these to fill out collection view")
    }
    
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
  
  /*
   Creates a batchLoader to coordinate an AWFPlace and AWFForecast request via their respective AWFObjectLoaders.
   Note: The reason that self.currentPlace is set initially and then later in the callback block of its placesLoader, 
   is that a AWFPlace instantiated with a CLLocation only has information about it's lat/long. Since I need information
   about the name of the state, country, etc.. associated with the lat/long, I need to make the request to AWFPlacesLoader.
   Then once the request finishes, I update self.currentPlace with another instance of AWFPlace that has full location details
   */
  func trackedLocationDidChange(location: CLLocation) {
    self.currentPlace = AWFPlace(coordinate: location.coordinate)
    
    let batchLoader: AWFBatchLoader = AWFBatchLoader()
    batchLoader.addLoader(self.placeLoader, forKey: AppKeys.PlacesLoader)
    batchLoader.addLoader(self.forecastLoader, forKey: AppKeys.ForecastLoader)
    batchLoader.setPlaceForAllLoaders(self.currentPlace)
    
    batchLoader.getWithCompletionBlock { (batchLoader, error) in
      if let placesLoader: AWFPlacesLoader = batchLoader.objectLoaderForKey(AppKeys.PlacesLoader) as? AWFPlacesLoader {
        placesLoader.getPlace(self.currentPlace!, options: AWFRequestOptions(), completion: { (places, error) in
          if places.count > 0 {
            if let validPlace: AWFPlace = places.first as? AWFPlace {
              self.currentPlace = validPlace
            }
          }
        })
      }
      
      if let forecastsLoader: AWFForecastsLoader = batchLoader.objectLoaderForKey(AppKeys.ForecastLoader) as? AWFForecastsLoader {
        forecastsLoader.getForecastForPlace(self.currentPlace!, options: AWFRequestOptions(), completion: { (forecasts, error) in
          if forecasts.count > 0 {
            if let forecast: AWFForecast = forecasts.first as? AWFForecast {
              self.updateUIElementsForForcast(forecast)
            }
          }
        })
      }
    }
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
    let imageView: UIImageView = UIImageView(image: UIImage(named: "cloudy_day"))
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

