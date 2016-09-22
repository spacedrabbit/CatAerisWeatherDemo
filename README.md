## CatAerisWeatherDemo
Simple Weather App using the [Aeris Weather API](http://www.aerisweather.com/support/docs/)

![Aeris Demo App Screenshot](http://i.imgur.com/QHc6oHC.png)

---
### Swift 2.2 -> 3.0 Conversion Notes
- As part of this update, I needed to wait for Snapkit to become 3.0 compatible. Checking the Issues of the repo earlier today, it appears that this has been resolved as of a day or two. It is unclear whether the resulting issues are from a change in 3.0 (likely for the issue with the collectionView) or from a change to Snapkit (like for the constraints issues on the collection view). 
- Problem: The collectionView was not reloading its data
  - Prior to the update, the collectionView in use was updated by a "manager" class that had a `.reloadData()` call in the `willSet` property observer of its `[AWFForecastPeriod]` property. Following the update, this property observer was still being called, but at a time offset by enough as to not invoke `.reloadData()`. How was this observed? Well, while a breakpoint proved that the property observer *was* being called, another breakpoint in the `collectionViews` datasource functions were not being called following that. After determining that the collectionView still had a reference to it's delegate/datasource, debugging moved on. 
  - Solution: For whatever reason, it became necessary to make a `.reloadData()` call in both `willSet` AND `didSet` to ensure that the collection would reload when expected. The bug would remain if only either `willSet` or `didSet` was present; meaning **both** had to make the call for this to take effect.  At this time, it is not clear as to what change specifically caused this, but problems with how Snapkit was updating its constraints may give a clue to a change in the lifecycle of the views. 
- Problem: Snapkit would throw in cases where there was a call to `snp.updateConstraint` in `layoutSubviews`
  - On throwing, Snapkit would say that it could not find the existing constraint to update... suggesting that the `layoutSubviews` call was being made before my `configureConstraints` (which seems unlikely since `configureConstraints` is called in the view's initialization) or that there was a race condition experienced or... other reasons. 
  - Solution: Moving constraint configurations (that required a later update) for affected views into `layoutSubviews` seems to have fixed the problem without any noticeable side effects. 

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
- [SnapKit 3.0.1](https://github.com/SnapKit/SnapKit)
