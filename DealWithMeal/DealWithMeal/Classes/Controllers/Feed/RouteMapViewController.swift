//
//  RouteMapViewController.swift
//  JEM_CarPool_iOS
//
//  Created by Aleksandr Shoshiashvili on 09.03.16.
//  Copyright © 2016 JEM_CarPool_iOS. All rights reserved.
//

import UIKit
import GoogleMaps

class RouteMapViewController: MainViewController, CLLocationManagerDelegate {
  
  var mapView = GMSMapView()
  
  var locationManager = CLLocationManager()
  var didFindMyLocation = false
  var myCLLocation = CLLocation()
  var routePointLocationStr: String = ""
  var routePointMarker: GMSMarker?
  
  var restLocation = CLLocationCoordinate2D()
  
  var isShowRoute: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
                                                      longitude: 151.20, zoom: 12)
    mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
    mapView.myLocationEnabled = true
    self.view = mapView
    
    addMarkerToCoordinate(restLocation, title: "Rest", isStartPoint: false)
    
    mapView.delegate = self
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
    mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  deinit {
    mapView.removeObserver(self, forKeyPath: "myLocation")
  }
  
  // MARK: - Actions
  
  // MARK: - Marker func
  
  func addMarkerToCoordinate(coordinate: CLLocationCoordinate2D, title: String, isStartPoint: Bool) {
    let  position = coordinate
    print("\(position)")
    let marker = GMSMarker(position: position)
    marker.title = title
    
    if isStartPoint {
      marker.icon = UIImage(named: "Map_Pin-A")
    } else {
      marker.icon = UIImage(named: "Map_Pin-B")
    }
    
    marker.map = mapView
    
  }
  
  // MARK: - CLLocationManagerDelegate
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == CLAuthorizationStatus.AuthorizedWhenInUse {
      mapView.myLocationEnabled = true
    }
  }
  
  // MARK: - KVO
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if !didFindMyLocation {
      let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
      myCLLocation = myLocation
      mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 12)
      mapView.settings.myLocationButton = true
      didFindMyLocation = true
    }
  }
  
  // MARK: - Add overlay to map view
  
  func addPolylineWithEncodedStringInMap(encodedString: String) {
    let path = GMSMutablePath(fromEncodedPath: encodedString)
    let polyline = GMSPolyline(path: path)
    addPolyline(polyline)
  }
  
  func addPolyline(polyline: GMSPolyline) {
    polyline.strokeWidth = 5
    polyline.strokeColor = Theme.colors.defaultBlueColor()
    polyline.map = mapView
  }
  
  func addCornerMarkerPoints(srcLocation: CLLocation, destLocation: CLLocation, srcTitle: String, destTitle: String) {
    addMarkerToCoordinate(srcLocation.coordinate, title: srcTitle, isStartPoint: true)
    addMarkerToCoordinate(destLocation.coordinate, title: destTitle, isStartPoint: false)
  }
  
  // MARK: - Fetch address from geopoint
  
  func getPlacemarkFromCoordinate(coordinate: CLLocationCoordinate2D) {
    if self.routePointMarker != nil {
      self.routePointMarker?.map = nil
    }
    
    self.routePointMarker = GMSMarker(position: coordinate)
    self.routePointMarker?.map = self.mapView
    
    let routePointLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    
    let geoCoder:CLGeocoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(routePointLocation, completionHandler: { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
      if placemarks != nil {
        if placemarks?.count > 0 {
          
          let placemark = placemarks!.first!
          
          var routePointName = ""
          if placemark.subThoroughfare != nil {
            routePointName += "\(placemark.subThoroughfare!), "
          }
          if placemark.thoroughfare != nil {
            routePointName += "\(placemark.thoroughfare!), "
          }
          if placemark.administrativeArea != nil {
            routePointName += "\(placemark.administrativeArea!), "
          }
          if placemark.country != nil {
            routePointName += "\(placemark.country!)"
          }
          
          self.routePointLocationStr = routePointName
          self.routePointMarker?.title = self.routePointLocationStr
          
        } else {
          
          self.routePointLocationStr = ""
          
        }
      } else {
        self.routePointLocationStr = ""
      }
      
    })
  }
  
}

extension RouteMapViewController: GMSMapViewDelegate {
  
  // MARK: - GMSMapViewDelegate
  
  func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
    //    addMarkerToCoordinate(coordinate, title: "Add", isStartPoint: true)
    //    addOverlayToMapView(myCLLocation, destLocation: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    getPlacemarkFromCoordinate(coordinate)
  }
  
  func mapView(mapView: GMSMapView, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
    //    if !isShowRoute {
    //      getPlacemarkFromCoordinate(coordinate)
    //    }
  }
  
}