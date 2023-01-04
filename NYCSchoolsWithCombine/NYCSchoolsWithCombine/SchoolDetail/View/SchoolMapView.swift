//
//  SchoolMapView.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation
import MapKit

class SchoolMapView: UIView {
    
    lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var zoomStepper: UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(self.zoomStepperSelected), for: .valueChanged)
        stepper.backgroundColor = .white
        stepper.layer.cornerRadius = 10
        stepper.layer.borderWidth = 1.0
        stepper.layer.borderColor = UIColor.black.cgColor
        stepper.maximumValue = 15
        stepper.minimumValue = 0
        stepper.value = 10
        self.currentStepValue = 10
        stepper.stepValue = 1
        let scaleTransform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        let translateTransform = CGAffineTransform(translationX: -15, y: -5)
        stepper.transform = scaleTransform.concatenating(translateTransform)
        
        return stepper
    }()
    
    var currentStepValue: Double = 5.0
    
    private var region: MKCoordinateRegion?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        self.addSubview(self.mapView)
        self.mapView.bindToSuper(constant: 0)
        self.addSubview(self.zoomStepper)
        self.zoomStepper.topAnchor.constraint(equalTo: self.mapView.topAnchor, constant: 8).isActive = true
        self.zoomStepper.leadingAnchor.constraint(equalTo: self.mapView.leadingAnchor, constant: 8).isActive = true
    }
    
    func configure(schoolDetailViewModel: SchoolDetailViewModel?) {
        guard let latitudeStr = schoolDetailViewModel?.latitude,
              let longitudeStr = schoolDetailViewModel?.longitude,
              let latitude = Double(latitudeStr),
              let longitude = Double(longitudeStr) else {
            return
        }
        
        let annotation = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        annotation.coordinate = location
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: false)
        mapView.addAnnotation(annotation)
    }
    
    @objc
    func zoomStepperSelected() {
        var region = self.mapView.region
        if self.zoomStepper.value < self.currentStepValue {
            region.span.latitudeDelta = region.span.latitudeDelta * 2.0
            region.span.longitudeDelta = region.span.longitudeDelta * 2.0
        } else {
            region.span.latitudeDelta = region.span.latitudeDelta / 2.0
            region.span.longitudeDelta = region.span.longitudeDelta / 2.0
        }
        self.mapView.setRegion(region, animated: true)
        self.currentStepValue = self.zoomStepper.value
    }
    
}
