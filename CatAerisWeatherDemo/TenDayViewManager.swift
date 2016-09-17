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
  internal private(set) var forecasts: [AWFForecastPeriod] = [] {
    willSet {
      self.collectionView.reloadData()
    }
  }
  internal var collectionView: TenDayCollectionView = TenDayCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
  
  // singleton
  internal static let shared: TenDayViewManager = TenDayViewManager()
  private override init() {
    super.init()
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }
  
  internal func updateForecasts(forecasts: [AWFForecastPeriod]) {
    self.forecasts = forecasts
  }
  
  
  // MARK: UICollectionViewDataSource
  internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.forecasts.count
  }
  
  internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let collectionCell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(TenDayCollectionView.cellIdentifier, forIndexPath: indexPath)
    
    if let tenDayCell: TenDayCollectionViewCell = collectionCell as? TenDayCollectionViewCell {
      tenDayCell.tempLabel.text = "\(self.forecasts[indexPath.row].avgTempF)"
      tenDayCell.weekdayLabel.text = DateConversionHelper(withDate: self.forecasts[indexPath.row].timestamp).dateAsTenDayCellFormatted()
      tenDayCell.weatherIconImageView.image = WeatherAssetHelper.assetForPeriod(self.forecasts[indexPath.row])
    }

    return collectionCell
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    if section == 0 {
      return 7.0 // if this value is >= 8.0, it causes a second section to automatically be creatd by the flow layout... why on earth is this..
    }
    
    return 0.0
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: AppLayout.StandardMargin, left: 0.0, bottom: AppLayout.StandardMargin, right: AppLayout.StandardMargin)
  }
  
  func collectionView(collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
    return CGPoint(x: AppLayout.StandardMargin, y: AppLayout.StandardMargin)
  }
}