//
//  Helpers.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal struct IntensityCode {
  internal static let VeryLight: String = "VL"
  internal static let Light: String = "L"
  internal static let Heavy: String = "H"
  internal static let VeryHeavy: String = "VH"
  
  internal static func valueForCode(code: String) -> String? {
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

internal struct CloudCode {
  internal static let Clear: String = "CL"
  internal static let MostlySunny: String = "FW"
  internal static let PartlyCloudy: String = "SC"
  internal static let MostlyCloudy: String = "BK"
  internal static let Overcast: String = "OV"
  
  internal static func valueForCode(code: String) -> String? {
    switch code {
    case CloudCode.Clear:
      return "Clear"
    case CloudCode.MostlySunny:
      return "Mostly Sunny"
    case CloudCode.PartlyCloudy:
      return "Partly Cloudy"
    case CloudCode.MostlyCloudy:
      return "Mostly Cloudy"
    case CloudCode.Overcast:
      return "Overcast"
    default:
      return nil
    }
  }
}
