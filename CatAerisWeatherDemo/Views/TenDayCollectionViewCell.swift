//
//  TenDayCollectionViewCell.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/14/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class TenDayCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  private func configureConstraints() {
    self.containterView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.contentView)
    }
    
    self.tempLabel.snp_makeConstraints { (make) in
      make.center.equalTo(self.containterView)
      make.top.left.equalTo(self.containterView).offset(AppLayout.StandardMargin)
      make.right.bottom.equalTo(self.containterView).inset(AppLayout.StandardMargin)
    }
  }
  
  private func setupViewHierarchy() {
    self.contentView.addSubview(containterView)
    self.containterView.addSubview(tempLabel)
  }
  
  private func adjustSubclass() {
    
  }
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Inits
  internal lazy var containterView: UIView = {
    let view: UIView = UIView()
    
    return view
  }()
  
  internal lazy var tempLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Regular, size: 24.0)
    label.textColor = AppColors.StandardTextColor
    return label
  }()
}
