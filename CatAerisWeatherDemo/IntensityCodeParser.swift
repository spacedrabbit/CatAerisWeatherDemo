//
//  IntensityCodeParser.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/2/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal struct IntensityCode: CodeParser {
  internal static let VeryLight: String = "VL"
  internal static let Light: String = "L"
  internal static let Heavy: String = "H"
  internal static let VeryHeavy: String = "VH"
  
  internal static func valueForCode(_ code: String) -> String? {
    switch code {
    case IntensityCode.VeryLight:
      return "Very Light"
    case IntensityCode.Light:
      return "Light"
    case IntensityCode.Heavy:
      return "Heavy"
    case IntensityCode.VeryHeavy:
      return "Very heavy"
    default:
      return nil
    }
  }
}
