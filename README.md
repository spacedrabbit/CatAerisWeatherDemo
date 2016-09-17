## CatAerisWeatherDemo
Simple Weather App using the [Aeris Weather API](http://www.aerisweather.com/support/docs/)

![Aeris Demo App Screenshot](http://i.imgur.com/QHc6oHC.png)

---
### Project Tech of Interest
- CLLocation framework
- UICollectionView UI elements
- NSDateFormatter for light date conversion
- Custom fonts (Roboto via Google)
- Lightweight view controller by way of singleton & delegate design

---
### Usage and Issues
- Requires permission to access location on device
- If building on simulator, update Run scheme to set a default location
- Loading screen animation has some unexpected animation behavior

--- 
### Environment: 
Runs on Xcode 7.3.1 (Swift 2.2/2.3)

Project can be updated to Xcode 8/Swift 3.0 once SnapKit is updated to Swift 3 (as of this writting, it is having issues despite attempting to work off its [0.40 beta feature branch](https://github.com/SnapKit/SnapKit/tree/feature/0.40.0))

---
### Pods: 
- [Aeris Weather iOS SDK](http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/)
  - (Aeris Dependacy) [AFNetworking](https://github.com/AFNetworking/AFNetworking)
- [SnapKit 0.22.0](https://github.com/SnapKit/SnapKit)
