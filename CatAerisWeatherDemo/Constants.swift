//
//  Constants.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 8/31/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

let AERIS_ID: String = "aqwGb7NoFkJReYGPvZsRb"
let AERIS_SECRET: String = "CCX6wXXefNwT6AjYYHlebF9SSZkUA59Q7eG6ZmgQ"
let AERIS_NAMESPACE: String = "catthoughts.CatAerisWeatherDemo"

internal struct AppLayout {
  internal static let StandardMargin: CGFloat = 8.0
  internal static let StatusBar: CGFloat = 22.0
}

internal struct AppFont {
  internal static let StandardFont: UIFont = UIFont.systemFontOfSize(36.0, weight: UIFontWeightMedium)

  internal struct Roboto {
    internal static let FamilyName: String = "Roboto"
    internal static let Thin: String = "Roboto-Thin"
    internal static let Italic: String = "Roboto-Italic"
    internal static let BlackItalic: String = "Roboto-BlackItalic"
    internal static let Light: String = "Roboto-Light"
    internal static let BoldItalic: String = "Roboto-BoldItalic"
    internal static let Black: String = "Roboto-Black"
    internal static let LightItalic: String = "Roboto-LightItalic"
    internal static let ThinItalic: String = "Roboto-ThinItalic"
    internal static let Bold: String = "Roboto-Bold"
    internal static let Regular: String = "Roboto-Regular"
    internal static let Medium: String = "Roboto-Medium"
    internal static let MediumItalic: String = "Roboto-MediumItalic"
  }
  
  internal struct RobotoCondensed {
    internal static let FamilyName: String = "RobotoCondensed"
    internal static let Bold: String = "RobotoCondensed-Bold"
    internal static let Light: String = "RobotoCondensed-Light"
    internal static let BoldItalic: String = "RobotoCondensed-BoldItalic"
    internal static let Italic: String = "RobotoCondensed-Italic"
    internal static let Regular: String = "RobotoCondensed-Regular"
    internal static let LightItalic: String = "RobotoCondensed-LightItalic"
  }
  
}

internal struct AppColors {
  internal static let StandardBackground: UIColor = UIColor(red: 172.0/255.0, green: 240.0/255.0, blue: 242.0/255.0, alpha: 1.0)
  internal static let StandardTextColor: UIColor = UIColor(red: 243.0/255.0, green: 1.0, blue: 226.0/255.0, alpha: 1.0)
  internal static let DarkBackground: UIColor = UIColor(red: 34.0/255.0, green: 83.0/255.0, blue: 120.0/255.0, alpha: 1.0)
}

internal struct AppKeys {
  internal static let PlacesLoader: String = "placesLoader"
  internal static let ForecastLoader: String = "forecastLoader"
}

internal struct DateFormat {
  internal static let ISO8601: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
  
  internal static let ExtendedHumanReadable: String = "EEEE, MMM dd yyyy" //Saturday, Sep 03 2016
  internal static let ShortHumanReadable: String = "MMM dd" // Sep 03
  internal static let ComparisonFormat: String = DateFormat.MonthNumericPadded + DateFormat.NumericDatePadded + DateFormat.YearFull
  
  internal static let YearFull: String = "yyyy"
  
  internal static let MonthNumeric: String = "M"
  internal static let MonthNumericPadded: String = "MM"
  internal static let MonthShort: String = "MMM"
  internal static let MonthFull: String = "MMMM"
  
  internal static let DayOfTheWeekFull: String = "EEEE" // Saturday
  internal static let DayOfTheWeekShort: String = "E"
  
  internal static let NumericDate: String = "d"
  internal static let NumericDatePadded: String = "dd"
  
  internal static let TwelveHourShort: String = "h" // 4
  internal static let TwelveHourPadded: String = "hh" // 04
  internal static let TwentyFourHour: String = "H"
  internal static let TwentyFourHourPadded: String = "HH"
  
  internal static let Minutes: String = "m"
  internal static let MinutesPadded: String = "mm"
  
  internal static let TimeZoneShort: String = "zzz"
}
