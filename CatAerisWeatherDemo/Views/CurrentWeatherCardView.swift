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
  private var forecastPeriod: AWFForecastPeriod!
  private var currentPlace: AWFPlace!
  
  // MARK: - Initialization
  convenience init(withForecast forecast: AWFForecastPeriod, place: AWFPlace) {
    self.init(frame: CGRectZero)
    self.forecastPeriod = forecast
    self.currentPlace = place
    
    self.updateUI(withForecastPeriod: forecastPeriod!)
    self.updateUI(withPlace: currentPlace!)

    self.setupViewHierarchy()
    self.configureConstraints()
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
  private func configureConstraints() {
    self.containerView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.topInfoContainerView.snp_makeConstraints { (make) in
      make.top.left.right.equalTo(self.containerView)
      make.bottom.equalTo(self.containerView.snp_centerY)
    }
    
    self.bottomInfoContainerView.snp_makeConstraints { (make) in
      make.top.equalTo(self.topInfoContainerView.snp_bottom).offset(AppLayout.StandardMargin)
      make.left.right.bottom.equalTo(self.containerView)
    }
    
    // top container view contents
    self.currentTempLabel.snp_makeConstraints { (make) in
      make.left.top.bottom.equalTo(self.topInfoContainerView)
      make.right.equalTo(self.topInfoContainerView.snp_centerX)
    }
    
    self.feelsLikeLabel.snp_makeConstraints { (make) in
      make.top.right.equalTo(self.topInfoContainerView)
      make.left.equalTo(self.currentTempLabel.snp_right).offset(AppLayout.StandardMargin)
    }
    
    self.highTempLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.feelsLikeLabel.snp_bottom).offset(AppLayout.StandardMargin)
      make.left.equalTo(self.currentTempLabel.snp_right).offset(AppLayout.StandardMargin)
      make.right.equalTo(self.topInfoContainerView)
    }
    
    self.lowTempLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.highTempLabel.snp_bottom).offset(AppLayout.StandardMargin)
      make.left.equalTo(self.currentTempLabel.snp_right).offset(AppLayout.StandardMargin)
      make.right.bottom.equalTo(self.topInfoContainerView)
    }
    
    // bottom container view contents
    self.locationLabel.snp_makeConstraints { (make) in
      make.top.left.equalTo(bottomInfoContainerView)
    }
    
    self.fullDescriptionLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.locationLabel.snp_bottom).offset(AppLayout.StandardMargin)
      make.left.right.bottom.equalTo(self.bottomInfoContainerView)
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(containerView)
    
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
    self.currentTempLabel.text = "\(period.avgTempF)F"
    self.feelsLikeLabel.text = "Feels like \(period.feelslikeF)℉"
    self.highTempLabel.text = "Hi: \(period.maxTempF)℉"
    self.lowTempLabel.text = "Lo: \(period.minTempF)℉"
    self.fullDescriptionLabel.text = period.weatherFull
    
    self.alpha = 0.0
    UIView.animateWithDuration(0.25) {
      self.layoutIfNeeded()
      self.alpha = 1.0
    }
  }
  
  internal func updateUI(withPlace place: AWFPlace) {
    self.locationLabel.text = place.name + ", " + place.state
  }
  
  internal func updateUI(withForecastPeriod period: AWFForecastPeriod, place: AWFPlace) {
    self.updateUI(withForecastPeriod: period)
    self.updateUI(withPlace: place)
  }
  
  // MARK: - Lazy Inits
  internal lazy var containerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = AppColors.StandardBackground
    view.layer.shadowRadius = 2.0
    view.layer.shadowColor = AppColors.DarkBackground.CGColor
    return view
  }()
  
  internal lazy var topInfoContainerView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  internal lazy var bottomInfoContainerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = AppColors.StandardTextColor
    view.layer.shadowRadius = 2.0
    view.layer.shadowColor = AppColors.DarkBackground.CGColor
    return view
  }()
  
  internal lazy var currentTempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Thin, size: 88.0)
    label.textColor = AppColors.StandardTextColor
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var feelsLikeLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Light, size: 24.0)
    label.textColor = AppColors.StandardTextColor
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var highTempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Light, size: 24.0)
    label.textColor = AppColors.StandardTextColor
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  internal lazy var lowTempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Light, size: 24.0)
    label.textColor = AppColors.StandardTextColor
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
}
