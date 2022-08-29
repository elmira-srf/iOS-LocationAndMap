import UIKit

// CoreLocation is the library that gives you access to classes and functions related to location services
import CoreLocation

class ForwardGeocodingVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var txtLocationName: UITextField!
    @IBOutlet weak var lblResults: UILabel!
    
    
    // MARK: Geocoder variable
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func getLatLongPressed(_ sender: Any) {
        // 1.validate the input
        guard let locationName = txtLocationName.text, locationName.isEmpty == false else {
            lblResults.text = "Must enter a location name."
            return
        }
        
        // 2. Perform geocoding
        print("Attemping to find coordinates for \(locationName)")
        self.geocoder.geocodeAddressString(locationName) {
            //  ([CLPlacemark]?, Error?) in
            (resultsList, error) in
            
            if let err = error {
                print("An error occured during forward geocoding")
            }
            else {
                // we found some results
                print("Number of results found: \(resultsList!.count)")
                // extract the first result from the array
                // output it to the screen
                let locationResult:CLPlacemark = resultsList!.first!
                
                let lat = locationResult.location?.coordinate.latitude
                let lng = locationResult.location?.coordinate.longitude
                
                if let lat = lat, let lng = lng {
                    // 3. reset the form and wait for next input
                    self.lblResults.text = "The location is: \(lat), \(lng)"
                }
                else {
                    self.lblResults.text = "The coordinates are null"
                }
                // clear the textbox and wait for new input
                self.txtLocationName.text = ""
                
                
            }
                
        }
        
        
    }
    

}

