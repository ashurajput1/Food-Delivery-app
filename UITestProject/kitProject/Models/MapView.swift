
import SwiftUI
import MapKit
import CoreLocation

import MapKit
import SwiftUI

struct MaptView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State var loc:UserLocation?
    @Binding var isVisibleMap:Bool
    var coordinatee:CLLocationCoordinate2D?
       
       var body: some View {
           VStack {
               if let coordinate = locationManager.lastKnownLocation {
                   Text("Latitude: \(coordinate.latitude)")
                   
                   Text("Longitude: \(coordinate.longitude)")
                   Text("\(String(describing: loc?.location))")
                   Map {
//                       Annotation("hello", coordinate: locationManager.lastKnownLocation!) {
//                                                      VStack
//                                                      {
//                                                          Image("traffic")
//                                                              .resizable()
//                                                              .frame(width: 30,height: 30)
//                                                      }
//                                                  }
                       ForEach(locationManager.allCoordinates) { coordinate in
                           Annotation("hello", coordinate: coordinate.coordinate!) {
                               VStack
                               {
                                   Image("traffic")
                                       .resizable()
                                       .frame(width: 30,height: 30)
                               }
                           }
                       }

                   }
                   .mapStyle(.standard(elevation: .realistic))
                   .overlay(alignment: .topTrailing, content: {
                       Button(action: {
                           isVisibleMap = false
                       }, label: {
                           Image(systemName: "multiply")
                       })
                       .opacity(isVisibleMap ? 1:0)
                   })
               } else {
                   Button("Get location") {
                       locationManager.checkLocationAuthorization()
                   }
                   .buttonStyle(.borderedProminent)
                   Text("Unknown Location")
                   Text("\(String(describing: loc?.location))")
               }
           }
           .safeAreaInset(edge: .bottom) {
               HStack {
                   Button(action: {
                       locationManager.searchLocation(Place: "parking")
                       
                   }, label: {
                       Image("Parking")
                   })
               }

           }
       }
    
}
#Preview {
    MaptView(isVisibleMap: .constant(true))
}

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    var manager = CLLocationManager()
    @Published var allCoordinates:[coordinates] = []
    
    
    func checkLocationAuthorization() {
        
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined://The user choose allow or denny your app to get the location yet
            manager.requestWhenInUseAuthorization()
            
        case .restricted://The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
            print("Location restricted")
            
        case .denied://The user dennied your app to get location or disabled the services location or the phone is in airplane mode
            print("Location denied")
            
        case .authorizedAlways://This authorization allows you to use all location services and receive location events whether or not your app is in use.
            print("Location authorizedAlways")
            
        case .authorizedWhenInUse://This authorization allows you to use all location services and receive location events only when your app is in use
            print("Location authorized when in use")
            lastKnownLocation = manager.location?.coordinate
            
        @unknown default:
            print("Location service disabled")
        
        }
    }
    func searchLocation(Place:String){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "Parking"
        searchRequest.region = MKCoordinateRegion(center: lastKnownLocation!, span: MKCoordinateSpan(latitudeDelta: 0.00125, longitudeDelta: 0.00125))
        let search = MKLocalSearch(request: searchRequest)
        var Coordinates:[coordinates] = []
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                print(item.placemark.coordinate)
                Coordinates.append(coordinates(coordinate: item.placemark.coordinate))
                
            }
            self.allCoordinates = Coordinates
            
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
struct coordinates:Identifiable {
    let id = UUID()
    let coordinate:CLLocationCoordinate2D?
}
