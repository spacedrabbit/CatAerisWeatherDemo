//
//  Constants.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

let AERIS_ID: String = "aqwGb7NoFkJReYGPvZsRb"
let AERIS_SECRET: String = "CCX6wXXefNwT6AjYYHlebF9SSZkUA59Q7eG6ZmgQ"
let AERIS_NAMESPACE: String = "catthoughts.CatAerisWeatherDemo"

internal struct AppLayout {
  internal static let StandardMargin: CGFloat = 8.0
  internal static let StatusBar: CGFloat = 22.0
}

internal struct AppFont {
  internal static let StandardFont: UIFont = UIFont.systemFontOfSize(36.0, weight: UIFontWeightMedium)
}

internal struct AppColors {
  internal static let StandardBackground: UIColor = UIColor(red: 172.0/255.0, green: 240.0/255.0, blue: 242.0/255.0, alpha: 1.0)
  internal static let StandardTextColor: UIColor = UIColor(red: 243.0/255.0, green: 1.0, blue: 226.0/255.0, alpha: 1.0)
  internal static let DarkBackground: UIColor = UIColor(red: 34.0/255.0, green: 83.0/255.0, blue: 120.0/255.0, alpha: 1.0)
}