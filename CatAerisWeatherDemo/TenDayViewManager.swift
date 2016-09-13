//
//  TenDayViewManager.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/13/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class TenDayViewManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
  internal let collectionView: TenDayCollectionView = TenDayCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
  
  internal static let shared: TenDayViewManager = TenDayViewManager()
  private override init() {}
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}