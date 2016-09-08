//
//  LoadingView.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/5/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class LoadingView: UIView {
  private var centeredViewFinalFrame: CGRect? // = CGRectZero
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.animateSpinner()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.centeredAlignmentView.snp_updateConstraints { (make) in
      make.height.equalTo(self.centeredAlignmentView.snp_width)
    }
    
    self.centeredViewFinalFrame = self.centeredAlignmentView.frame
  }
  
  // MARK: - Setup
  private func configureConstraints() {
    self.blurryBackgrondView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.centeredAlignmentView.snp_makeConstraints { (make) in
      make.width.equalTo(self).multipliedBy(0.75)
      make.center.equalTo(self)
    }
    
    self.spinnerImageView.snp_makeConstraints { (make) in
      make.center.equalTo(self.centeredAlignmentView)
      make.size.equalTo(CGSizeMake(64.0, 64.0))
    }
    
    self.loadingLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.spinnerImageView.snp_bottom).offset(AppLayout.StandardMargin)
      make.left.right.lessThanOrEqualTo(self.centeredAlignmentView)
      make.centerX.equalTo(self.centeredAlignmentView)
    }
    
  }
  
  private func setupViewHierarchy() {
    self.addSubview(blurryBackgrondView)
    self.blurryBackgrondView.addSubview(centeredAlignmentView)

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
  
  internal func animateOut() {
    if let currentLocation: CGRect = self.centeredViewFinalFrame {
      
      let finalLocation: CGRect = CGRect(x: currentLocation.origin.x,
                                         y: currentLocation.origin.y + self.frame.size.height / 2.0 + currentLocation.size.height / 2.0,
                                         width: currentLocation.size.width,
                                         height: currentLocation.size.height)
      
      self.centeredViewFinalFrame = self.centeredAlignmentView.frame
      UIView.animateWithDuration(0.25, animations: {
        self.centeredAlignmentView.frame = finalLocation
        
        }, completion: { (complete) in
          if complete {
            UIView.animateWithDuration(0.2, animations: { 
              self.alpha = 0.0
              }, completion: { (complete) in
                self.removeFromSuperview()
            })
          }
      })
    }
  }
  
  // MARK: - Lazy Inits
  internal lazy var centeredAlignmentView: UIView = {
  let view: UIView = UIView()
    view.backgroundColor = AppColors.StandardTextColor
    view.layer.shadowColor = AppColors.DarkBackground.CGColor
    view.layer.shadowRadius = 5.0
    view.layer.shadowOffset = CGSizeMake(2.0, 4.0)
    view.layer.shadowOpacity = 0.65
  return view
  }()
 
  internal lazy var spinnerImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "loading_spinner"))
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
  
  internal lazy var loadingLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.MediumItalic, size: 18.0)
    label.textColor = AppColors.DarkBackground
    label.text = "Loading"
    label.textAlignment = .Center
    return label
  }()
  
  internal lazy var blurryBackgrondView: UIView = {
    let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
    return view
  }()
}
