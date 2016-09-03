//
//  Helpers.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

// hoping that loading all of these doesn't impact performance too much
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
}


internal class DateConversionHelper {
  
  
  // MARK: - iVars
  internal var fullWeatherString: String = ""
  internal var convertedDate: NSDate?
  internal var dateFormatter: NSDateFormatter = NSDateFormatter()
  
  
  // MARK: - Inits
  init(weatherString: String) {
    self.fullWeatherString = weatherString
    self.convertedDate = self.dateFormatter.dateFromString(self.fullWeatherString)
  }
  
  init(withDate date: NSDate) {
    self.convertedDate = date
    self.fullWeatherString = self.dateFormatter.stringFromDate(self.convertedDate!)
  }
  
  
  // MARK: - Conversions
  internal func dateAsExtendedReadable() -> String {
    self.dateFormatter.dateFormat = DateFormat.ExtendedHumanReadable
    return self.dateFormatter.stringFromDate(self.convertedDate!)
  }
  
  internal func dateAsShortReadable() -> String {
    self.dateFormatter.dateFormat = DateFormat.ShortHumanReadable
    return self.dateFormatter.stringFromDate(self.convertedDate!)
  }
  
  internal func dateAsComparable() -> String {
    self.dateFormatter.dateFormat = DateFormat.ComparisonFormat
    return self.dateFormatter.stringFromDate(self.convertedDate!)
  }
  
  
  // MARK: - Helpers
  internal func isTodaysDate() -> Bool {
    let storedDate: String = self.dateAsComparable()
    let newDate: String = DateConversionHelper(withDate: NSDate()).dateAsComparable()
    
    if storedDate == newDate {
      print("Both string are the same")
      return true
    }
    
    return false
  }
}