//
//  LocationCell.swift
//  RxDataSourcesSample
//
//  Created by Siarhei Dukhovich on 6/19/19.
//  Copyright © 2019 Siarhei Dukhovich. All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

  @IBOutlet private var mapView: MKMapView!

  var lat: Double? {
    didSet {
      updatePin()
    }
  }

  var lon: Double? {
    didSet {
      updatePin()
    }
  }

  private func updatePin() {
    guard let lat = lat,
      let lon = lon,
      let mapView = mapView else { return }
    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000.0, longitudinalMeters: 1000.0)
    mapView.setRegion(mapView.regionThatFits(region), animated: false)
    let pin = MKPointAnnotation()
    pin.coordinate = coordinate
    mapView.addAnnotation(pin)
    mapView.isUserInteractionEnabled = false
  }
}
