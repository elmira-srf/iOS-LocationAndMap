import UIKit

import CoreLocation     // geocoding & user location

class UserLocationVC: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Location Manager
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var btnGetLocation: UIButton!
    @IBOutlet weak var btnStopGettingLocation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the location manager
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        // when you need a user's location, you must ask for permission
        self.locationManager.requestWhenInUseAuthorization()
        
    }

    @IBAction func getUserLocationPressed(_ sender: Any) {
        // request the user's location
        self.locationManager.startUpdatingLocation()
        print("Getting user locations....")
        // TODO: Disable the button so it can't be pressed again
        
        btnGetLocation.isEnabled = false
        btnStopGettingLocation.isEnabled = true
        
       
    }
    
    @IBAction func stopGettingLocationPressed(_ sender: Any) {
        
        self.locationManager.stopUpdatingLocation()
        
        btnStopGettingLocation.isEnabled = false
        btnGetLocation.isEnabled = true
        
        
        
    }
    // this function wil run EVERY time the user location changes/update
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Received a location!")
        
        if let lastKnownLocation =  locations.first {
            let lat = lastKnownLocation.coordinate.latitude
            let lng = lastKnownLocation.coordinate.longitude
            print("Current location: \(lat), \(lng), current speed: \(lastKnownLocation.speed)")
        }
    }
}
