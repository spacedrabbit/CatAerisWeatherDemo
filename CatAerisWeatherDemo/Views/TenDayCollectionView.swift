//
//  TenDayCollectionView.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/13/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class TenDayCollectionView: UICollectionView {
  
  // ---------------------------------------------------------------- //
  // MARK: - Initialization
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    self.setCollectionViewLayout(self.flowLayout, animated: false)
    
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
    return layout
  }()

}
