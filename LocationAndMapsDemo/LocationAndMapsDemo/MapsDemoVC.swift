import UIKit

// 1. import MapKit library
import MapKit

class MapsDemoVC: UIViewController {
    // MARK: Outlets
    
    @IBOutlet weak var txtMarkerLat: UITextField!    
    @IBOutlet weak var txtMarkerLng: UITextField!
    @IBOutlet weak var txtMarkerDesc: UITextField!
    
    // 2. create outlet to the map view ui element
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. configure the mapview
        // - center of the map: specifies the lat,lng coordinate of the center of the map
        let centerOfMapCoordinate = CLLocationCoordinate2D(latitude: 45.5017, longitude: -73.5673)
        
        // - span: specifies the zoom level (zoom in by choosing a smaller number, zoom out by choosing a larger number)
        let zoomLevel = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        // - region: object that represents the area of the map that should be displayed
        let visibleRegion = MKCoordinateRegion(center: centerOfMapCoordinate , span: zoomLevel)
        
        // configure the map with these settings
        mapView.setRegion(visibleRegion, animated: true)
        
        // 4. Add a marker to the map
        
        // - create a marker
        let mapMarker = MKPointAnnotation()
        // - coordinate where you want to place the marker
        mapMarker.coordinate = centerOfMapCoordinate
        // - optional: description of the coordinate
        mapMarker.title = "This is my pin!"

        // - place the marker on the map
        mapView.addAnnotation(mapMarker)
    }

    @IBAction func addMarkerPressed(_ sender: Any) {
        // 1. Validate form fields
        // - fields cannot be empty
        guard let lat = txtMarkerLat.text, lat.isEmpty == false, let lng = txtMarkerLng.text, lng.isEmpty == false else {
            print("Latitude and longitude cannot be empty.")
            return
        }
        // - must be able to convert lat/lng to a double
        guard let lat = Double(lat), let lng = Double(lng) else {
            print("Must enter a valid latitude and longitude")
            return
        }
        
        // 2. Construct the map marker
        let markerToAdd = MKPointAnnotation()
        
        // - 2a. use the lat lng to make the marker
        markerToAdd.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        
        // - 2b. if marker description is empty then don't provide one
        if let desc = txtMarkerDesc.text, desc.isEmpty == true {
            print("Desc is empty")
        }
        else {
            markerToAdd.title = txtMarkerDesc.text!
        }

        // 3. Add to the map
        mapView.addAnnotation(markerToAdd)
        
        
        // 3. Clear all textboxes and wait for next input
        txtMarkerDesc.text = ""
        txtMarkerLng.text = ""
        txtMarkerLng.text = ""
        
        print("Marker added.")
    }
    
    @IBAction func clearAllMarkersPressed(_ sender: Any) {
        print("All markers cleared.")
        let markersList:[MKAnnotation] = mapView.annotations
        mapView.removeAnnotations(markersList)
    }
    
}

