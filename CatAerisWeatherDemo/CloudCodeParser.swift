//
//  CloudCodeParser.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/2/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit


internal struct CloudCode: CodeParser {
  internal static let Clear: String = "CL"
  internal static let MostlySunny: String = "FW"
  internal static let PartlyCloudy: String = "SC"
  internal static let MostlyCloudy: String = "BK"
  internal static let Overcast: String = "OV"
  
  internal static func valueForCode(_ code: String) -> String? {
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
