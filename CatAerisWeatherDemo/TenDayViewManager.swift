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

internal class TenDayViewManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
  internal private(set) var forecasts: [AWFForecast] = []
  internal var collectionView: TenDayCollectionView = TenDayCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
  
  // singleton
  internal static let shared: TenDayViewManager = TenDayViewManager()
  private override init() {
    super.init()
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }
  
  internal func updateForecasts(forecasts: [AWFForecast]) {
    self.forecasts = forecasts
  }
  
  
  // MARK: UICollectionViewDataSource
  internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10 //self.forecasts.count
  }
  
  internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let collectionCell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(TenDayCollectionView.cellIdentifier, forIndexPath: indexPath)
    
    // TODO: make cell subclass
    let backgroundView: UIView = UIView()
    backgroundView.backgroundColor = UIColor.redColor()

    collectionCell.contentView.addSubview(backgroundView)
    backgroundView.snp_makeConstraints { (make) in
      make.edges.equalTo(collectionCell.contentView)
    }
    
    return collectionCell
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

}