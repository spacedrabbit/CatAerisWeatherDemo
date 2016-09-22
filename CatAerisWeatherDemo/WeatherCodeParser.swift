//
//  WeatherCodeParser.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//
import Foundation
import UIKit

// [coverage]:[intensity]:[weather]
internal struct WeatherCode: CodeParser {
  internal static let Hail: String = "A"
  internal static let BlowingDust: String = "BD"
  internal static let BlowingSand: String = "BN"
  internal static let Mist: String = "BR"
  internal static let BlowingSnow: String = "BS"
  internal static let BlowingSpray: String = "BY"
  internal static let Fog: String = "F"
  internal static let Frost: String = "FR"
  internal static let Haze: String = "H"
  internal static let IceCrystals: String = "IC"
  internal static let IceFog: String = "IF"
  internal static let IcePelletsOrSleet: String = "IP"
  internal static let Smoke: String = "K"
  internal static let Drizzle: String = "L"
  internal static let Rain: String = "R"
  internal static let RainShowers: String = "RW"
  internal static let RainSnowMix: String = "RS" //	Rain/snow mix
  internal static let SnowSleetMix: String = "SI" //	Snow/sleet mix
  internal static let WintryMix: String = "WM" //	Wintry mix (snow, sleet, rain)
  internal static let Snow: String = "S"
  internal static let SnowShowers: String = "SW"
  internal static let Thunderstorms: String = "T"
  internal static let UnknownPrecipitation: String = "UP" //	Unknown precipitation
  internal static let VolcanicAsh: String = "VA"
  internal static let Waterspouts: String = "WP"
  internal static let FreezingFog: String = "ZF"
  internal static let FreezingDrizzle: String = "ZL"
  internal static let FreezingRain: String = "ZR"
  internal static let FreezingSpray: String = "ZY"
  
  internal static func valueForCode(_ code: String) -> String? {
    switch code {
    case WeatherCode.Hail:
      return "Hail"
    case WeatherCode.BlowingDust:
      return "Blowing Dust"
    case WeatherCode.BlowingSand:
      return "Blowing Sand"
    case WeatherCode.Mist:
      return "Mist"
    case WeatherCode.BlowingSnow:
      return "Blowing Snow"
    case WeatherCode.BlowingSpray:
      return "Blowing Spray"
    case WeatherCode.Fog:
      return "Fog"
    case WeatherCode.Frost:
      return "Frost"
    case WeatherCode.Haze:
      return "Haze"
    case WeatherCode.IceCrystals:
      return "Ice crystals"
    case WeatherCode.IceFog:
      return "Ice fog"
    case WeatherCode.IcePelletsOrSleet:
      return "Ice pellets/Sleet"
    case WeatherCode.Smoke:
      return "Smoke"
    case WeatherCode.Drizzle:
      return "Drizzle"
    case WeatherCode.Rain:
      return "Rain"
    case WeatherCode.RainShowers:
      return "Rain showers"
    case WeatherCode.RainSnowMix:
      return "Rain/snow mix"
    case WeatherCode.SnowSleetMix:
      return "Snow/sleet mix"
    case WeatherCode.WintryMix:
      return "Wintry mix (snow, sleet, rain)"
    case WeatherCode.Snow:
      return "Snow"
    case WeatherCode.SnowShowers:
      return "Snow showers"
    case WeatherCode.Thunderstorms:
      return "Thunderstorms"
    case WeatherCode.UnknownPrecipitation:
      return "Unknown Precipitation"
    case WeatherCode.VolcanicAsh:
      return "Volcanic ash"
    case WeatherCode.Waterspouts:
      return "Water spouts"
    case WeatherCode.FreezingFog:
      return "Freezing fog"
    case WeatherCode.FreezingDrizzle:
      return "Freezing drizzle"
    case WeatherCode.FreezingRain:
      return "Freezing rain"
    case WeatherCode.FreezingSpray:
      return "Freezing spray"
    default:
      return nil
    }
  }
}
