//
//  CurricularView.swift
//  CurricularCounter
//
//  Created by Aaron Gangemi on 30/1/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import Foundation
import MapKit
class CurricularView: UIViewController
{
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var HoursLabel: UILabel!
    
    @IBOutlet weak var GoalLabel: UILabel!
    
    @IBOutlet weak var StartTimeLabel: UILabel!
    
    
    @IBOutlet weak var EndTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToMap()
        activityLabel.text = curricularName[myIndex]
        HoursLabel.text = String(curricularHours[myIndex])
        GoalLabel.text = String(goalArray[myIndex])
        if(Int(GoalLabel.text!)! < 0)
        {
            GoalLabel.text = "0"
        }
        StartTimeLabel.text = startDateArray[myIndex]
        EndTimeLabel.text = endDateArray[myIndex]
        
        // Do any additional setup after loading the view.
    }
    
    
    func addToMap()
    {
        //Ignores user
        UIApplication.shared.beginIgnoringInteractionEvents()
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        //create search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = LocationArray[myIndex]
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                //get data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                //create annotation
                let annotation = MKPointAnnotation()
                annotation.title = LocationArray[myIndex]
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                //zoom on annotation
                let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                var span = MKCoordinateSpan()
                span.latitudeDelta = 0.1
                span.longitudeDelta = 0.1
                var region = MKCoordinateRegion()
                region.center = coordinate
                region.span = span
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    func dateChange() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let newDate = dateFormatter.date(from: startDateArray[myIndex])
        return newDate!
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    


}
