//
//  DateConversionHelper.swift
//  CatAerisWeatherDemo
//
//  Created by Louis Tur on 9/15/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//
import Foundation

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


internal class DateConversionHelper {
  
  // MARK: - iVars
  internal var fullWeatherString: String = ""
  internal var convertedDate: Date?
  internal var dateFormatter: DateFormatter = DateFormatter()
  
  
  // MARK: - Inits
  init(weatherString: String) {
    self.fullWeatherString = weatherString
    self.convertedDate = self.dateFormatter.date(from: self.fullWeatherString)
  }
  
  init(withDate date: Date) {
    self.convertedDate = date
    self.fullWeatherString = self.dateFormatter.string(from: self.convertedDate!)
  }
  
  
  // MARK: - Conversions
  internal func dateAsExtendedReadable() -> String {
    self.dateFormatter.dateFormat = DateFormat.ExtendedHumanReadable
    return self.dateFormatter.string(from: self.convertedDate!)
  }
  
  internal func dateAsShortReadable() -> String {
    self.dateFormatter.dateFormat = DateFormat.ShortHumanReadable
    return self.dateFormatter.string(from: self.convertedDate!)
  }
  
  internal func dateAsTenDayCellFormatted() -> String {
    self.dateFormatter.dateFormat = DateFormat.DayOfTheWeekShort
    return self.dateFormatter.string(from: self.convertedDate!)
  }
  
  // this is used to create a standardized string from a date that i can use to compare easily while ignoring minor differences between NSDates
  internal func dateAsComparable() -> String {
    self.dateFormatter.dateFormat = DateFormat.ComparisonFormat
    return self.dateFormatter.string(from: self.convertedDate!)
  }
  
  
  // MARK: - Helpers
  internal func isTodaysDate() -> Bool {
    let storedDate: String = self.dateAsComparable()
    let newDate: String = DateConversionHelper(withDate: Date()).dateAsComparable()
    
    if storedDate == newDate {
      //      print("Both string are the same")
      return true
    }
    
    return false
  }
}
