//
//  HomeDetailsViewController.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 26.02.2023.
//

import UIKit
import MapKit
import Lottie

class HomeDetailsViewController: UIViewController {

    //   MARK: - UI Elements -> Halil İbrahim Elkan..
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsMapKit: MKMapView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    //   MARK: - Properties -> Halil İbrahim Elkan.
    var titleString = ""
    var sizeLabelString = ""
    var depthLabelString = ""
    var dateTimeLabelString = ""
    var lat = ""
    var lng = ""
    private let locationManager = CLLocationManager()
    let jsonName = "location"
    var animationView: LottieAnimationView! = nil
    //   MARK: - Life Cyle -> Halil İbrahim Elkan..
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        fetchLocation()
    }
    
    //   MARK: - Functions -> Halil İbrahim Elkan..
    func design(){
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        let fullName    = "\(dateTimeLabelString)"
        let fullNameArr = fullName.components(separatedBy: " ")

        let date = fullNameArr[0]
        let time = fullNameArr[1]
        
        titleLabel.text = "\(titleString)"
        sizeLabel.text = "\(sizeLabelString)"
        depthLabel.text = "Derinlik: \(depthLabelString) km"
        dateTimeLabel.text = "Tarih: \(date)  Saat: \(time) "
        detailsMapKit.delegate = self
        
        if sizeLabelString <= "3.5"{
            sizeLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        if sizeLabelString >= "3.5"{
            sizeLabel.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        }
        if sizeLabelString >= "5.0"{
            sizeLabel.textColor = #colorLiteral(red: 0.8513526523, green: 0.2283288845, blue: 0.1996252306, alpha: 1)
        }
        if sizeLabelString >= "7.0"{
            sizeLabel.textColor = #colorLiteral(red: 0.3243370449, green: 0.08698571087, blue: 0.07605057342, alpha: 1)
        }
        
    }
    
    private func fetchLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        }
    }
    //   MARK: - Actions -> Halil İbrahim Elkan..
 
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}


extension HomeDetailsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        let oahuCenter = CLLocation(latitude: Double("\(lat)") ?? 0.0, longitude: Double("\(lng)") ?? 0.0)
        
        let annotation = MKPointAnnotation()

            let lastLocation = oahuCenter

              annotation.coordinate = lastLocation.coordinate

              detailsMapKit.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: lastLocation.coordinate, span: span)
        
        detailsMapKit.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
          let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000000)
        detailsMapKit.setCameraZoomRange(zoomRange, animated: true)
    }
}

extension HomeDetailsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.description)
//        view.image = UIImage(named: "map")
        let animation = LottieAnimation.named(jsonName)
        animationView = LottieAnimationView(animation: animation)
        
        animationView!.contentMode = .scaleAspectFit
        self.animationView.loopMode = .loop
        view.addSubview(self.animationView)
        self.animationView.play()
        return view
    }
}
