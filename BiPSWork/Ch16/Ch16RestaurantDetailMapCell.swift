//
//  Ch16RestaurantDetailMapCell.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/15.
//

import UIKit
import MapKit

class Ch16RestaurantDetailMapCell: UITableViewCell {
    @IBOutlet var mapView: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(location: String){
        // 获取地址
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location, completionHandler: {placemarks, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks{
                // 获取解析到的第一个地址
                let placemark = placemarks[0]
                // 添加地图标识
                let annotation = MKPointAnnotation()
                if let location = placemark.location{
                    // 显示标识
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    // 设置缩放比
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }
}
