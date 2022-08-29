import UIKit

import CoreLocation

class ReverseGeocodingVC: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var txtLat: UITextField!
    @IBOutlet weak var txtLng: UITextField!
    @IBOutlet weak var lblResults: UILabel!
    
    
    // MARK: Geocoding variable
    let geocoder = CLGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getLocationNamePressed(_ sender: Any) {
        
        // 1. validate input
        guard let lat = txtLat.text, lat.isEmpty == false else {
            lblResults.text = "Latitude cannot be empty"
            return
        }
        guard let lng = txtLng.text, lng.isEmpty == false else {
            lblResults.text = "Longitude cannot be empty"
            return
        }
        
        // the entered coordinates must be a double
        guard let lng = Double(lng), let lat = Double(lat) else {
            lblResults.text = "Must enter a valid latitude and longitude"
            return
        }
        
        // 2. do reverse geocoding
        // TODO
        let locationToFind = CLLocation(latitude: lat, longitude: lng)
        geocoder.reverseGeocodeLocation(locationToFind) {
           //  [CLPlacemark]?, Error? in
            (resultsList, error) in
            
            if let err = error {
                print("Error during the reverse geocoding")
                return
            }
            else {
                print("Matching location found: \(resultsList!.count)")
                let locationResult:CLPlacemark = resultsList!.first!
                print(locationResult)
                
                
                print("Getting location data:")
                let name = locationResult.name ?? "Not available"
                let street = locationResult.thoroughfare ?? "Not available"
                let city = locationResult.locality ?? "Not available"
                let postalCode = locationResult.postalCode ?? "Not available"
                let country = locationResult.country ?? "Not available"
                
                let output = "Name: \(name)\nStreet: \(street)\nCity: \(city)\nPostal Code: \(postalCode)\nCountry: \(country)"
                self.lblResults.text = "\(output)"
                
                // 3. reset the form and wait for next input
                self.txtLat.text = ""
                self.txtLng.text = ""
                
            }
            
        }
    }
    
}

