//
//  WeatherCodeParser.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//
import Foundation
import UIKit

internal struct WeatherCodeParser {
  // [coverage]:[intensity]:[weather]
  
  internal typealias ParsedWeather = (coverage: String? , intensity: String?, weather: String?)
  static func parseWeatherCode(code: String) -> ParsedWeather? {
    
    var codeComponents = code.componentsSeparatedByString(":")
    if codeComponents.count == 3 {
      let coverageCode: String? = WeatherCodeParser.coverageCodeParser(forCode: codeComponents[0])
      let intensityCode: String? = WeatherCodeParser.intensityCodeParser(forCode: codeComponents[1])
      let weatherCode: String? = WeatherCodeParser.weatherCodeParser(forCode: codeComponents[2])
      
      if weatherCode == nil {
        // for some reason, the returned value is refering to the clouds code rather than the weather codes
        // this is a quick solution to get back a valid value to display
        let cloudCode = CloudCode.valueForCode(codeComponents[2])
        return (coverageCode, intensityCode, cloudCode)
      }
      return (coverageCode, intensityCode, weatherCode)
    }
    return nil
  }
  
  static func cloudCodeParser(forCode code: String) -> String? {
    return CloudCode.valueForCode(code)
  }
  
  static func coverageCodeParser(forCode code: String) -> String? {
    return nil // not implemented
  }
  
  static func intensityCodeParser(forCode code: String)  -> String? {
    return IntensityCode.valueForCode(code)
  }
  
  static func weatherCodeParser(forCode code: String)  -> String? {
    return nil // not implemented
  }
}