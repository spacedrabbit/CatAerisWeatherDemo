//
//  LoadingView.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/5/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class LoadingView: UIView {
  
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    self.backgroundView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.centeredAlignmentView.snp_makeConstraints { (make) in
      make.center.equalTo(self.backgroundView)
    }
    
    self.cloudIconImageView.snp_makeConstraints { (make) in
      make.top.centerX.equalTo(self.centeredAlignmentView)
      make.left.right.lessThanOrEqualTo(self.centeredAlignmentView)
      make.size.equalTo(CGSizeMake(64.0, 64.0))
    }
    
    self.loadingLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.cloudIconImageView.snp_bottom).offset(AppLayout.StandardMargin)
      make.bottom.equalTo(self.centeredAlignmentView)
    }
    
  }
  
  private func setupViewHierarchy() {
    self.addSubview(backgroundView)
    self.backgroundView.addSubview(centeredAlignmentView)
    
    self.centeredAlignmentView.addSubview(cloudIconImageView)
    self.centeredAlignmentView.addSubview(spinnerImageView)
    self.centeredAlignmentView.addSubview(loadingLabel)
  }
  
  
  // MARK: - Animations
  private func animateSpinner() {
    self.userInteractionEnabled = false
    
    UIView.animateKeyframesWithDuration(1.25, delay: 0.0, options: [.Repeat, .BeginFromCurrentState, .CalculationModePaced], animations: { () -> Void in
      
      UIView.addKeyframeWithRelativeStartTime(0.0,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(90.0)
      })
      
      UIView.addKeyframeWithRelativeStartTime(0.25,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(180.0)
      })
      
      UIView.addKeyframeWithRelativeStartTime(0.50,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(270.0)
      })
      
      UIView.addKeyframeWithRelativeStartTime(0.75,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(360.0)
      })
      
    }) { (complete: Bool) -> Void in
      if complete {
        
      }
    }
    
  }
  
  private func stopAnimatingSpinner() {
    self.userInteractionEnabled = true
    self.spinnerImageView.layer.removeAllAnimations()
  }

  private func rotationTransform(degrees: CGFloat) -> CATransform3D {
    let radians: CGFloat = degrees * (CGFloat(M_PI) / 180.0)
    return CATransform3DMakeRotation(radians, 0.0, 0.0, -1.0)
  }
  
  
  // MARK: - Lazy Inits
  internal lazy var backgroundView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = AppColors.StandardTextColor
    return view
  }()
  
  internal lazy var centeredAlignmentView: UIView = {
  let view: UIView = UIView()
  return view
  }()
  
  internal lazy var cloudIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "loading_spinner"))
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
 
  internal lazy var spinnerImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "loading_spinner"))
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
  
  internal lazy var loadingLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.Thin, size: 72.0)
    label.textColor = AppColors.DarkBackground
    label.text = "Locating..."
    return label
  }()
}
