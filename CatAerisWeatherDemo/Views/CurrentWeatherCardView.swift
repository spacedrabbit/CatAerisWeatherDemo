//
//  CurrentWeatherCardView.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/4/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import Aeris

class CurrentWeatherCardView: UIView {
  fileprivate var forecastPeriod: AWFForecastPeriod!
  fileprivate var currentPlace: AWFPlace!
  
  // MARK: - Initialization
  convenience init(withForecast forecast: AWFForecastPeriod, place: AWFPlace) {
    self.init(frame: CGRect.zero)
    self.forecastPeriod = forecast
    self.currentPlace = place
    
    self.updateUI(withForecastPeriod: forecastPeriod!)
    self.updateUI(withPlace: currentPlace!)

//    self.setupViewHierarchy()
//    self.configureConstraints()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  // MARK: - Setup
  fileprivate func configureConstraints() {
    self.containerView.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.weatherIconImageView.snp.makeConstraints { (make) in
      make.top.equalTo(self.containerView)
      make.size.equalTo(CGSize(width: 96.0, height: 96.0))
      make.centerX.equalTo(self.containerView)
    }
    
    self.topInfoContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(self.weatherIconImageView.snp.bottom)
      make.left.right.equalTo(self.containerView)
    }
    
    self.bottomInfoContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(self.topInfoContainerView.snp.bottom).offset(AppLayout.StandardMargin)
      make.left.right.bottom.equalTo(self.containerView)
    }
    
    // top container view contents
    self.currentTempLabel.snp.makeConstraints { (make) in
      make.left.top.bottom.equalTo(self.topInfoContainerView)
      make.right.equalTo(self.topInfoContainerView.snp.centerX)
    }
    
    self.feelsLikeLabel.snp.makeConstraints { (make) in
      make.top.right.equalTo(self.topInfoContainerView)
      make.left.equalTo(self.currentTempLabel.snp.right).offset(AppLayout.StandardMargin)
    }
    
    self.highTempLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.feelsLikeLabel.snp.bottom).offset(AppLayout.StandardMargin)
      make.left.equalTo(self.currentTempLabel.snp.right).offset(AppLayout.StandardMargin)
      make.right.equalTo(self.topInfoContainerView)
    }
    
    self.lowTempLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.highTempLabel.snp.bottom).offset(AppLayout.StandardMargin)
      make.left.equalTo(self.currentTempLabel.snp.right).offset(AppLayout.StandardMargin)
      make.right.bottom.equalTo(self.topInfoContainerView)
    }
    
    // bottom container view contents
    self.locationLabel.snp.makeConstraints { (make) in
      make.top.left.equalTo(bottomInfoContainerView).offset(AppLayout.StandardMargin)
    }
    
    self.fullDescriptionLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.locationLabel.snp.bottom).offset(AppLayout.StandardMargin)
      make.left.equalTo(self.bottomInfoContainerView).offset(AppLayout.StandardMargin)
      make.bottom.right.equalTo(self.bottomInfoContainerView).inset(AppLayout.StandardMargin)
    }
  }
  
  fileprivate func setupViewHierarchy() {
    self.addSubview(containerView)
    
    self.containerView.addSubview(weatherIconImageView)
    self.containerView.addSubview(topInfoContainerView)
    self.containerView.addSubview(bottomInfoContainerView)
    
    self.topInfoContainerView.addSubview(currentTempLabel)
    self.topInfoContainerView.addSubview(feelsLikeLabel)
    self.topInfoContainerView.addSubview(highTempLabel)
    self.topInfoContainerView.addSubview(lowTempLabel)
    
    self.bottomInfoContainerView.addSubview(fullDescriptionLabel)
    self.bottomInfoContainerView.addSubview(locationLabel)
  }

  
  // MARK: - Update UI
  internal func updateUI(withForecastPeriod period: AWFForecastPeriod) {
    self.currentTempLabel.text = "\(period.avgTempF as NSNumber)F"
    self.feelsLikeLabel.text = "Feels like \(period.feelslikeF as NSNumber)℉"
    self.highTempLabel.text = "Hi: \(period.maxTempF as NSNumber)℉"
    self.lowTempLabel.text = "Lo: \(period.minTempF as NSNumber)℉"
    self.fullDescriptionLabel.text = period.weatherFull
    self.weatherIconImageView.image = WeatherAssetHelper.assetForPeriod(period)
    
    self.alpha = 0.0
    UIView.animate(withDuration: 0.25, animations: {
      self.layoutIfNeeded()
      self.alpha = 1.0
    }) 
  }
  
  internal func updateUI(withPlace place: AWFPlace) {
    self.locationLabel.text = place.name + ", " + place.state
  }
  
  internal func updateUI(withForecastPeriod period: AWFForecastPeriod, place: AWFPlace) {
    self.updateUI(withForecastPeriod: period)
    self.updateUI(withPlace: place)
  }
  
  // MARK: - Lazy Inits
  // containers
  internal lazy var containerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = AppColors.StandardTextColor
    view.layer.shadowRadius = 2.0
    view.layer.shadowColor = AppColors.DarkBackground.cgColor
    view.layer.shadowOpacity = 1.0
    view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    return view
  }()
  
  internal lazy var topInfoContainerView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  internal lazy var bottomInfoContainerView: UIView = {
    let view: UIView = UIView()
    view.layer.shadowRadius = 2.0
    view.layer.shadowColor = AppColors.DarkBackground.cgColor
    return view
  }()
  
  // label
  internal lazy var currentTempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Thin, size: 88.0)
    label.textColor = AppColors.DarkBackground
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var feelsLikeLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Light, size: 24.0)
    label.textColor = AppColors.DarkBackground
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var highTempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Light, size: 24.0)
    label.textColor = AppColors.DarkBackground
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var lowTempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Light, size: 24.0)
    label.textColor = AppColors.DarkBackground
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var locationLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Regular, size: 14.0)
    label.textColor = AppColors.DarkBackground
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var fullDescriptionLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Regular, size: 18.0)
    label.textColor = AppColors.DarkBackground
    label.numberOfLines = 3
    return label
  }()
  
  // image
  internal lazy var weatherIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "cloudy_day"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
}
