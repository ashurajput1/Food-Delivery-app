//
//  MapView.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 21/08/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var selectedLocation: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let coordinate = view.annotation?.coordinate {
                parent.selectedLocation = coordinate
            }
        }

        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            for view in views {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
                view.addGestureRecognizer(tapGesture)
            }
        }

        @objc func handleTap(gesture: UITapGestureRecognizer) {
            guard let view = gesture.view as? MKAnnotationView else { return }
            if let coordinate = view.annotation?.coordinate {
                parent.selectedLocation = coordinate
            }
        }
    }
}
