//
//  AerisCodeParser.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/2/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

protocol CodeParser {
  static func valueForCode(_ code: String) -> String?
}

internal typealias ParsedWeather = (coverage: String? , intensity: String?, weather: String?)
internal struct AerisCodeParser {
  // [coverage]:[intensity]:[weather]
  static func componentsForCode(_ code: String) -> [String] {
    return code.components(separatedBy: ":")
  }
  
  static func parseWeatherCode(_ code: String) -> ParsedWeather? {
    var codeComponents = componentsForCode(code)
    if codeComponents.count == 3 {
      let coverageCode: String? = AerisCodeParser.coverageCodeParser(forCode: codeComponents[0])
      let intensityCode: String? = AerisCodeParser.intensityCodeParser(forCode: codeComponents[1])
      let weatherCode: String? = AerisCodeParser.weatherCodeParser(forCode: codeComponents[2])
      
      if coverageCode == nil && intensityCode == nil && weatherCode == nil {
        // apparently, if the last component matches a cloud code it means that all values are
        // being returned as nil and that the cloud code should be the only thing used to
        // determine weather info
        let cloudCode = CloudCode.valueForCode(codeComponents[2])
        return (nil, nil, cloudCode)
      }
      return (coverageCode, intensityCode, weatherCode)
    }
    return nil
  }
  
  static func cloudCodeParser(forCode code: String) -> String? {
    return CloudCode.valueForCode(code)
  }
  
  static func coverageCodeParser(forCode code: String) -> String? {
    return CoverageCode.valueForCode(code)
  }
  
  static func intensityCodeParser(forCode code: String)  -> String? {
    return IntensityCode.valueForCode(code)
  }
  
  static func weatherCodeParser(forCode code: String)  -> String? {
    return WeatherCode.valueForCode(code)
  }
}
