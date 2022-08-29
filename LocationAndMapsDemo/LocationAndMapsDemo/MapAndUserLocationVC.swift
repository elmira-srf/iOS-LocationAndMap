import UIKit

import MapKit
import CoreLocation

class MapAndUserLocationVC: UIViewController, CLLocationManagerDelegate {

    // outlets    
    @IBOutlet weak var mapView: MKMapView!
    
    // location manager
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        // configure the map
        let centerOfMapCoordinate = CLLocationCoordinate2D(latitude: 37.3319, longitude: -122.0302)
        let zoomLevel = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let visibleRegion = MKCoordinateRegion(center: centerOfMapCoordinate, span: zoomLevel)
        self.mapView.setRegion(visibleRegion, animated: true)
        
        // show the user's location
        self.mapView.showsUserLocation = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 1. get the last known location
        if let lastKnownLocation =  locations.first {
            let lat = lastKnownLocation.coordinate.latitude
            let lng = lastKnownLocation.coordinate.longitude
            print("Current location: \(lat), \(lng), current speed: \(lastKnownLocation.speed)")
            
            // 2. update the visible map region to match where the user is
            let updatedCenterOfMapCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let updatedVisibleRegion = MKCoordinateRegion(center: updatedCenterOfMapCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.mapView.setRegion(updatedVisibleRegion, animated:true)
            
        }
        
    }
    

}
