//
//  LoadingView.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/5/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class LoadingView: UIView {
  fileprivate var centeredViewFinalFrame: CGRect? // = CGRectZero
  
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
//    self.centeredAlignmentView.snp.updateConstraints { (make) in
//      make.height.equalTo(self.centeredAlignmentView.snp.width)
//    }
//    
    self.centeredViewFinalFrame = self.centeredAlignmentView.frame
  }
  
  // MARK: - Setup
  fileprivate func configureConstraints() {
    self.blurryBackgrondView.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.centeredAlignmentView.snp.makeConstraints { (make) in
      make.width.equalTo(self).multipliedBy(0.75)
      make.center.equalTo(self)
    }
    
    self.spinnerImageView.snp.makeConstraints { (make) in
      make.center.equalTo(self.centeredAlignmentView)
      make.size.equalTo(CGSize(width: 64.0, height: 64.0))
    }
    
    self.loadingLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.spinnerImageView.snp.bottom).offset(AppLayout.StandardMargin)
      make.left.right.lessThanOrEqualTo(self.centeredAlignmentView)
      make.centerX.equalTo(self.centeredAlignmentView)
    }
    
  }
  
  fileprivate func setupViewHierarchy() {
    self.addSubview(blurryBackgrondView)
    self.blurryBackgrondView.addSubview(centeredAlignmentView)

    self.centeredAlignmentView.addSubview(spinnerImageView)
    self.centeredAlignmentView.addSubview(loadingLabel)
  }
  
  
  // MARK: - Animations
  fileprivate func animateSpinner() {
    self.isUserInteractionEnabled = false
    
    UIView.animateKeyframes(withDuration: 1.25, delay: 0.0, options: [.repeat, .beginFromCurrentState, .calculationModePaced], animations: { () -> Void in
      
      UIView.addKeyframe(withRelativeStartTime: 0.0,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(90.0)
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.25,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(180.0)
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.50,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(270.0)
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.75,
        relativeDuration: 0.25,
        animations: { () -> Void in
          self.spinnerImageView.layer.transform = self.rotationTransform(360.0)
      })
      
    }) { (complete: Bool) -> Void in
      if complete {
        
      }
    }
    
  }
  
  fileprivate func stopAnimatingSpinner() {
    self.isUserInteractionEnabled = true
    self.spinnerImageView.layer.removeAllAnimations()
  }

  fileprivate func rotationTransform(_ degrees: CGFloat) -> CATransform3D {
    let radians: CGFloat = degrees * (CGFloat(M_PI) / 180.0)
    return CATransform3DMakeRotation(radians, 0.0, 0.0, -1.0)
  }
  
  // TODO: this is bugged, but i dont like it anyhow, replace entirely
  internal func animateOut() {
    if let currentLocation: CGRect = self.centeredViewFinalFrame {
      
      let finalLocation: CGRect = CGRect(x: currentLocation.origin.x,
                                         y: currentLocation.origin.y + self.frame.size.height / 2.0 + currentLocation.size.height / 2.0,
                                         width: currentLocation.size.width,
                                         height: currentLocation.size.height)
      
      self.centeredViewFinalFrame = self.centeredAlignmentView.frame
      UIView.animate(withDuration: 0.25, animations: {
        self.centeredAlignmentView.frame = finalLocation
        
        }, completion: { (complete) in
          if complete {
            UIView.animate(withDuration: 0.2, animations: { 
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
    view.layer.shadowColor = AppColors.DarkBackground.cgColor
    view.layer.shadowRadius = 5.0
    view.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
    view.layer.shadowOpacity = 0.65
  return view
  }()
 
  internal lazy var spinnerImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "loading_spinner"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  internal lazy var loadingLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont(name: AppFont.Roboto.MediumItalic, size: 18.0)
    label.textColor = AppColors.DarkBackground
    label.text = "Loading"
    label.textAlignment = .center
    return label
  }()
  
  internal lazy var blurryBackgrondView: UIView = {
    let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
    return view
  }()
}
