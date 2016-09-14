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
      make.center.equalTo(self.contentView)
      make.top.left.equalTo(self.contentView).offset(AppLayout.StandardMargin)
      make.right.bottom.equalTo(self.contentView).inset(AppLayout.StandardMargin)
    }
    
    self.weekdayLabel.snp_makeConstraints { (make) in
      make.top.centerX.equalTo(self.containterView)
      make.left.lessThanOrEqualTo(self.containterView).offset(AppLayout.StandardMargin)
      make.right.lessThanOrEqualTo(self.containterView).inset(AppLayout.StandardMargin)
    }
    
    self.tempLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.weekdayLabel.snp_bottom).offset(AppLayout.StandardMargin)
      make.centerX.equalTo(self.weekdayLabel)
      make.bottom.lessThanOrEqualTo(self.containterView)
    }
  }
  
  private func setupViewHierarchy() {
    self.contentView.addSubview(containterView)
    
    self.containterView.addSubview(weekdayLabel)
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
    label.textAlignment = .Center
    return label
  }()
  
  internal lazy var weekdayLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Thin, size: 18.0)
    label.textColor = AppColors.StandardTextColor
    label.textAlignment = .Center
    return label
  }()
}
