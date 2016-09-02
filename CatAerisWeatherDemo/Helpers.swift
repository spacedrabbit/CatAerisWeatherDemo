//
//  Helpers.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

// [coverage]:[intensity]:[weather]

internal struct CoverageCode {
  internal static let AreasOf: String = "AR" //	Areas of
  internal static let Brief: String = "BR" //	Brief
  internal static let ChanceOf: String = "C"	// Chance of
  internal static let Definite: String = "D"	// Definite
  internal static let Frequent: String = "FQ"	// Frequent
  internal static let Intermittent: String = "IN" // IN	Intermittent
  internal static let Isolated: String = "IS" // IS	Isolated
  internal static let Likely: String = "L"  // L	Likely
  internal static let Numerous: String = "NM" // NM	Numerous
  internal static let Occasional: String = "O"  // O	Occasional
  internal static let Patchy: String = "PA" // PA	Patchy
  internal static let PeriodsOf: String = "PD" // PD	Periods of
  internal static let SlightChance: String = "S"  // S	Slight chance
  internal static let Scattered: String = "SC" // SC	Scattered
  internal static let InTheVicinity: String = "VC" // VC	In the vicinity/Nearby
  internal static let WideSpread: String = "WD" // WD	Widespread
  
  internal static func valueForCode(code: String) -> String? {
    switch code {
    case CoverageCode.AreasOf:
      return "Areas of"
    case CoverageCode.Brief:
      return "Brief"
    case CoverageCode.ChanceOf:
      return "Chance of"
    case CoverageCode.Definite:
      return "Definite"
    case CoverageCode.Frequent:
      return "Frequent"
    case CoverageCode.Intermittent:
      return "Intermittent"
    case CoverageCode.Isolated:
      return "Isolated"
    case CoverageCode.Likely:
      return "Likely"
    case CoverageCode.Numerous:
      return "Numerous"
    case CoverageCode.Occasional:
      return "Occasional"
    case CoverageCode.Patchy:
      return "Patchy"
    case CoverageCode.PeriodsOf:
      return "Periods of"
    case CoverageCode.SlightChance:
      return "Slight chance of"
    case CoverageCode.Scattered:
      return "Scattered"
    case CoverageCode.InTheVicinity:
      return "In the vicinity/Nearby"
    case CoverageCode.WideSpread:
      return "Widespread"
    default:
      return nil
    }
  }
}

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

internal struct WeatherCode {
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
  
  internal static func valueForCode(code: String) -> String? {
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