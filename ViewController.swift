//
//  ViewController.swift
//  PolyLine
//
//  Created by takashi on 2015/06/17.
//  Copyright (c) 2015年 takashi Otaki. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var latitudeArray: [CLLocationDegrees] = [35.681382,35.675069,35.665498,35.655646,35.645736,35.630152,35.6197,35.626446,35.633998,35.64669,35.658517,35.670168,35.683061,35.690921,35.701306,35.712285,35.721204,35.728926,35.731401,35.733492,35.736489,35.738062,35.732135,35.727772,35.720495,35.713768,35.707438,35.698683,35.69169,35.681382]
    var longitudeArray: [CLLocationDegrees] = [139.766084,139.763328,139.75964,139.756749,139.747575,139.74044,139.728553,139.723444,139.715828,139.710106,139.701334,139.702687,139.702042,139.700258,139.700044,139.703782,139.706587,139.71038,139.728662,139.739345,139.746875,139.76086,139.766787,139.770987,139.778837,139.777254,139.774632,139.774219,139.770883,139.766084]
    
    var myMapView: MKMapView = MKMapView()
    
    var timer = NSTimer()
    var count = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 経度緯度を設定.
        let myLan: CLLocationDegrees = 35.680129
        let myLon: CLLocationDegrees = 139.738734
        
        // 地図の中心の座標.
        var center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLan, myLon)
        
        // mapViewを生成.
        myMapView.frame = self.view.frame
        myMapView.center = self.view.center
        myMapView.centerCoordinate = center
        myMapView.delegate = self
        
        // 縮尺を指定.
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
        
        // regionをmapViewに追加.
        myMapView.region = myRegion
        
        // viewにmapViewを追加.
        self.view.addSubview(myMapView)
        
        CLLocationArray()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:  Selector("addTrain"), userInfo: nil, repeats: true)

    }
    
    
    func CLLocationArray() {
        
        var coordinatesYamanote:[CLLocationCoordinate2D] = []
        
        for var index = 0; index < latitudeArray.count; ++index {
            
            var coordinate = CLLocationCoordinate2D(latitude: latitudeArray[index], longitude: longitudeArray[index])
            
            coordinatesYamanote.append(coordinate)
            
        }
        
        // polyline作成.
        let YamanotePolyLine: MKPolyline = MKPolyline(coordinates: &coordinatesYamanote, count: coordinatesYamanote.count)
        
        // mapViewに線を描画.
        myMapView.addOverlay(YamanotePolyLine)
        
        
    }
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        // rendererを生成.
        let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        // 線の太さを指定.
        myPolyLineRendere.lineWidth = 5
        
        // 線の色を指定.
        myPolyLineRendere.strokeColor = UIColor(red: (155/255.0), green: (203/255.0), blue: (64/255.0), alpha: 1.0)
        
        return myPolyLineRendere
    }
    
    
    func addTrain() {
        
        // ピンを生成.
        var myPin: MKPointAnnotation = MKPointAnnotation()
        
        myMapView.removeAnnotations(myMapView.annotations)
        
        // 中心点.
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeArray[count], longitudeArray[count])
        
        // 座標を設定.
        myPin.coordinate = center
        
        // MapViewにピンを追加.
        myMapView.addAnnotation(myPin)
        
        count++
        
        if count == latitudeArray.count {
            timer.invalidate()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

