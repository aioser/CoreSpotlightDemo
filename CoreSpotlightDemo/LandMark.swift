//
//  LandMark.swift
//  HelloSwiftUI
//
//  Created by sama 刘 on 2021/6/16.
//

import Foundation
import CoreLocation
import UIKit

struct LandMark: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let state: String
    let park: String
    let description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rives = "Rivers"
        case mountains = "Mountains"
    }
    
    private var imageName: String
    var image: UIImage? {
        UIImage(named: imageName)
    }
    var featrueImage: UIImage? {
        isFeatured ? UIImage(named: imageName + "_feature") : nil
    }
        
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    private var coordinates: Coordinates
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}

