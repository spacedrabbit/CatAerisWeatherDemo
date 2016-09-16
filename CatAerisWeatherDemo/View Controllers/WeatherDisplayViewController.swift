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
  internal var tenDayManager: TenDayViewManager = TenDayViewManager.shared
  
  internal let tenDayForecastView: TenDayCollectionView = TenDayViewManager.shared.collectionView
  
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
    
    self.currentWeatherCard.snp_makeConstraints { (make) in
      make.top.equalTo(self.containerView).offset(AppLayout.StandardMargin)
      make.centerX.equalTo(self.containerView)
      make.width.equalTo(self.containerView).inset(AppLayout.StandardMargin)
    }
    
    self.tenDayForecastView.snp_makeConstraints { (make) in
      make.bottom.equalTo(self.containerView).inset(AppLayout.StandardMargin)
      make.left.equalTo(self.containerView).offset(AppLayout.StandardMargin)
      make.right.equalTo(self.containerView).inset(AppLayout.StandardMargin)
      make.top.equalTo(self.currentWeatherCard.snp_bottom)
    }
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(containerView)

    self.containerView.addSubview(currentWeatherCard)
    self.containerView.addSubview(tenDayForecastView)
    
    self.view.addSubview(loadingView)

    self.view.backgroundColor = AppColors.DarkBackground
    self.containerView.layer.cornerRadius = AppLayout.StandardMargin
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - UI Updates
  internal func updateUIElements(place: AWFPlace, forecast: AWFForecast, completion: (()->Void)?) {
    
    self.currentWeatherCard.updateUI(withPlace: place)
    
    var weeklyForecastPeriods: [AWFForecastPeriod] = []
    for period in forecast.periods as! [AWFForecastPeriod] {
      
      let dateHelper = DateConversionHelper(withDate: period.timestamp)
      if dateHelper.isTodaysDate() {
        self.currentWeatherCard.updateUI(withForecastPeriod: period)
        continue
      }
      weeklyForecastPeriods.append(period)
    }

    if weeklyForecastPeriods.count > 0 {
      self.tenDayManager.updateForecasts(weeklyForecastPeriods)
    }
    
    if completion != nil {
      completion!()
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
    self.updateUIElements(place, forecast: forecast) {
      // TODO: make sure interactively is fine, and that the view is actually removed
      self.loadingView.animateOut()
    }
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
    label.font = AppFont.StandardFont
    label.textColor = AppColors.StandardTextColor
    return label
  }()
  
  internal lazy var loadingView: LoadingView = {
    let loadingView: LoadingView = LoadingView()
    return loadingView
  }()
  
}

