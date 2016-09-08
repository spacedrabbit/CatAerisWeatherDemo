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

class WeatherDisplayViewController: UIViewController, LocationHelperDelegate, AerisRequestManagerDelegate {
  
  internal var currentPlace: AWFPlace = AWFPlace()
  internal var locationHelper: LocationHelper = LocationHelper.manager
  internal var aerisManager: AerisRequestManager = AerisRequestManager.shared
  
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.locationHelper.delegate = self
    self.aerisManager.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  // ---------------------------------------------------------------- //
  // MARK: - Setup
  private func configureConstraints() {
    self.loadingView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
    
    self.containerView.snp_makeConstraints { (make) in
      make.top.equalTo(self.view).offset(AppLayout.StandardMargin + AppLayout.StatusBar)
      make.left.equalTo(self.view).offset(AppLayout.StandardMargin)
      make.bottom.right.equalTo(self.view).inset(AppLayout.StandardMargin)
    }
    
    self.weatherIconImageView.snp_makeConstraints { (make) in
      make.top.equalTo(self.containerView).offset(AppLayout.StandardMargin)
      make.centerX.equalTo(self.containerView)
      make.size.equalTo(CGSize(width: 128.0, height: 128.0))
    }
    
    self.currentWeatherCard.snp_makeConstraints { (make) in
      make.top.equalTo(self.weatherIconImageView.snp_bottom).offset(AppLayout.StandardMargin)
      make.centerX.equalTo(self.weatherIconImageView)
      make.width.equalTo(self.containerView).inset(AppLayout.StandardMargin)
    }
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(containerView)
    self.containerView.addSubview(weatherIconImageView)
    self.containerView.addSubview(currentWeatherCard)
    
    self.view.addSubview(loadingView)

    self.view.backgroundColor = AppColors.DarkBackground
    self.containerView.layer.cornerRadius = AppLayout.StandardMargin
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - UI Updates
  internal func updateUIElementsForForcast(forecast: AWFForecast, completion: (()->Void)?) {
    
    // no real reason to use a control label here, I just wanted to try them
    periodLoop: for period in forecast.periods as! [AWFForecastPeriod] {
      let dateHelper = DateConversionHelper(withDate: period.timestamp)
      if dateHelper.isTodaysDate() {
        self.currentWeatherCard.updateUI(withForecastPeriod: period)
        continue periodLoop
      }
      // TODO: create collection view data source from remaining forecast info
      if completion != nil {
        completion!()
      }
    }
    
  }
  
  internal func updateUIElementsForPlace(place: AWFPlace) {
    self.currentWeatherCard.updateUI(withPlace: place)
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
    self.aerisManager.beginPlaceRequestForCoordinates(location.coordinate)
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - AerisRequestManagerDelegate
  func placesRequestDidFinish(place: AWFPlace) {
    self.currentPlace = place
    self.aerisManager.beginForecastRequestForPlace(self.currentPlace)
  }
  
  func placesRequestDidFailWithError(error: NSError) {
    print("Places request failed: \(error)")
  }
  
  func forecastRequestDidFinish(forecast: AWFForecast, forPlace place: AWFPlace) {
    self.updateUIElementsForForcast(forecast) { () in
      self.loadingView.animateOut()
      // TODO: make sure interactively is fine, and that the view is actually removed
    }
    
    self.updateUIElementsForPlace(place)
  }
  
  func forecastRequestDidFailWithError(error: NSError) {
    print("Forecast request failed: \(error)")
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Init
  internal lazy var containerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = AppColors.StandardBackground
    return view
  }()
  
  internal lazy var currentWeatherCard: CurrentWeatherCardView = CurrentWeatherCardView(frame: CGRectZero)
  
  internal lazy var locationLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "Loading..."
    label.font = AppFont.StandardFont
    label.textColor = AppColors.StandardTextColor
    return label
  }()
  
  internal lazy var weatherIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "cloudy_day"))
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
  
  internal lazy var loadingView: LoadingView = {
    let loadingView: LoadingView = LoadingView()
    return loadingView
  }()

}

