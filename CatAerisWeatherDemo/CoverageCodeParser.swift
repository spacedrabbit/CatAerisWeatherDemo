//
//  CoverageCodeParser.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/2/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal struct CoverageCode: CodeParser {
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
  
  internal static func valueForCode(_ code: String) -> String? {
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
