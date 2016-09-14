//
//  TenDayCollectionView.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/13/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class TenDayCollectionView: UICollectionView {
  internal static let cellIdentifier: String = "tenDayCellIdentifier"
  
  // ---------------------------------------------------------------- //
  // MARK: - Initialization
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    // TODO: customize both of these later
    self.setCollectionViewLayout(self.flowLayout, animated: false)
    self.backgroundColor = UIColor.blueColor()
    self.registerClass(TenDayCollectionViewCell.self, forCellWithReuseIdentifier: TenDayCollectionView.cellIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Instances
  internal lazy var flowLayout: UICollectionViewFlowLayout = {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .Horizontal
    layout.minimumInteritemSpacing = 8.0
    layout.sectionHeadersPinToVisibleBounds = true
    layout.estimatedItemSize = CGSize(width: 100.0, height: 100.0) // TODO: adjust size based on height after layout occurs
    layout.sectionInset = UIEdgeInsets(top: 0.0, left: AppLayout.StandardMargin, bottom: 0.0, right: AppLayout.StandardMargin)
    return layout
  }()

}
