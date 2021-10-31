//
//  ContentView.swift
//  LocaNav
//
//  Created by Prateek on 31/10/21.
//
import MapKit
import CoreLocationUI
import SwiftUI

struct ContentView: View {
    
    
    @StateObject private var viewModel = ContentViewModel()
    
    
    var body: some View{
    
    
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .tint(.pink)
            
             LocationButton(.currentLocation){
                 viewModel.requestAllowOnceLocationPermission()
                 
             }
             .foregroundColor(.white)
             .cornerRadius(8)
             .labelStyle(.iconOnly)
             .symbolVariant(.fill)
             .tint(.purple)
}
    }}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class ContentViewModel : NSObject, ObservableObject , CLLocationManagerDelegate{
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    
    
    let locationManager = CLLocationManager()
    
    override init()  {
        
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission()
    
    {
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let CurLocation = locations.first
        
        else{
            return
        }
        
        
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: CurLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error.localizedDescription)
    }
        
       
            
        }
        

    
    
    


