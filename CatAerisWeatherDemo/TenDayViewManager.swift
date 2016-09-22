//
//  TenDayViewManager.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/13/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit
import Aeris

internal class TenDayViewManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  internal fileprivate(set) var forecasts: [AWFForecastPeriod] = [] {
    didSet {
      self.collectionView.reloadData()
    }
    willSet {
      self.collectionView.reloadData()
    }
  }
  internal var collectionView: TenDayCollectionView = TenDayCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  // singleton
  internal static let shared: TenDayViewManager = TenDayViewManager()
  fileprivate override init() {
    super.init()
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }
  
  internal func updateForecasts(_ forecasts: [AWFForecastPeriod]) {
    self.forecasts = forecasts
  }
  
  
  // MARK: UICollectionViewDataSource
  internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.forecasts.count
  }
  
  internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let collectionCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TenDayCollectionView.cellIdentifier, for: indexPath)
    
    if let tenDayCell: TenDayCollectionViewCell = collectionCell as? TenDayCollectionViewCell {
      tenDayCell.tempLabel.text = "\(self.forecasts[(indexPath as NSIndexPath).row].avgTempF as NSNumber)"
      tenDayCell.weekdayLabel.text = DateConversionHelper(withDate: self.forecasts[(indexPath as NSIndexPath).row].timestamp).dateAsTenDayCellFormatted()
      tenDayCell.weatherIconImageView.image = WeatherAssetHelper.assetForPeriod(self.forecasts[(indexPath as NSIndexPath).row])
    }

    return collectionCell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    if section == 0 {
      return 7.0 // if this value is >= 8.0, it causes a second section to automatically be creatd by the flow layout... why on earth is this..
    }
    
    return 0.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: AppLayout.StandardMargin, left: 0.0, bottom: AppLayout.StandardMargin, right: AppLayout.StandardMargin)
  }
  
  func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
    return CGPoint(x: AppLayout.StandardMargin, y: AppLayout.StandardMargin)
  }
}
