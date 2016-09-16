//
//  Helpers.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit
import Aeris

// hoping that loading all of these doesn't impact performance too much (does not seem to)
internal struct WeatherAssetHelper {
  // Clouds
  internal static let CloudyDay: UIImage? = UIImage(named: "cloudy_day")
  internal static let CloudyNight: UIImage? = UIImage(named: "cloudy_night")
  internal static let CloudyLight: UIImage? = UIImage(named: "cloudy_light")
  internal static let CloudyHeavy: UIImage? = UIImage(named: "cloudy_heavy")
  
  // General Use
  internal static let Earth: UIImage? = UIImage(named: "earth")
  internal static let Eclipse: UIImage? = UIImage(named: "eclipse")
  internal static let Sunny: UIImage? = UIImage(named: "sunny")
  
  // Moon
  internal static let MoonFull: UIImage? = UIImage(named: "moon_full")
  internal static let MoonWaningCrescent: UIImage? = UIImage(named: "moon_waning_crescent")
  internal static let MoonWaxingCrescent: UIImage? = UIImage(named: "moon_waxing_crescent")
  
  // Rain
  internal static let RainDrop: UIImage? = UIImage(named: "rain_drop")
  internal static let RainyDay: UIImage? = UIImage(named: "rainy_day")
  internal static let RainyNight: UIImage? = UIImage(named: "rainy_night")
  internal static let Rainy: UIImage? = UIImage(named: "rainy")
  internal static let Umbrella: UIImage? = UIImage(named: "umbrella")
  
  // Stormy
  internal static let Hail: UIImage? = UIImage(named: "hail")
  internal static let Lightning: UIImage? = UIImage(named: "lightning")
  internal static let Snowflake: UIImage? = UIImage(named: "snowflake")
  internal static let Storm: UIImage? = UIImage(named: "storm")
  internal static let Tornado: UIImage? = UIImage(named: "tornado")
  internal static let Windy: UIImage? = UIImage(named: "windy")
  
  // Temperature Indicators
  internal static let Celcius: UIImage? = UIImage(named: "temp_scale_cel")
  internal static let Farenheit: UIImage? = UIImage(named: "temp_scale_far")
  internal static let ThermometerMid: UIImage? = UIImage(named: "therm")
  
  internal static func assetForPeriod(period: AWFForecastPeriod) -> UIImage? {
    
    if let coverageCode: ParsedWeather = AerisCodeParser.parseWeatherCode(period.weatherCoded) {
      
      
      
    }
    
    return nil
  }
}
