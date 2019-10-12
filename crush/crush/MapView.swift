//
//  MapView.swift
//  crush
//
//  Created by Alexander Zhang on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    let manager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView

        init(_ control: MapView) {
            self.control = control
        }
        
        func mapView(_ view: MKMapView, didUpdate userLocation: MKUserLocation) {
            let location = view.userLocation.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
            view.addOverlay(MKCircle(center: location, radius: 100))
        }
        
        func mapView(_ view: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           guard let circle = overlay as? MKCircle else { return MKOverlayRenderer() }
           let renderer = MKCircleRenderer(circle: circle)
           renderer.strokeColor = .blue
           renderer.fillColor = .blue
           renderer.alpha = 0.2
           return renderer
        }
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
