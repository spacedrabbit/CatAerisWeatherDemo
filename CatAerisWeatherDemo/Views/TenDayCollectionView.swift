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
    self.backgroundColor = UIColor.clear
    // TODO: customize flow layout
    self.showsHorizontalScrollIndicator = false
    self.setCollectionViewLayout(self.flowLayout, animated: false)
    self.register(TenDayCollectionViewCell.self, forCellWithReuseIdentifier: TenDayCollectionView.cellIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Instances
  internal lazy var flowLayout: UICollectionViewFlowLayout = {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 1.0
    layout.sectionHeadersPinToVisibleBounds = true
    layout.estimatedItemSize = CGSize(width: 100.0, height: 100.0) // TODO: adjust size based on height after layout occurs
    layout.sectionInset = UIEdgeInsets(top: AppLayout.StandardMargin, left: 0.0, bottom: AppLayout.StandardMargin, right: AppLayout.StandardMargin)
    return layout
  }()

}
