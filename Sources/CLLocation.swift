//
//  CLLocation.swift
//  CoreLinuxLocation
//
//  Created by Jimmy Chan on 4/23/16.
//  Copyright © 2016 Projek J. All rights reserved.
//

import Foundation

typealias CLLocationDegrees = Double
typealias CLLocationAccuracy = Double
typealias CLLocationDistance = Double
typealias CLLocationSpeed = Double
typealias CLLocationDirection = Double

public struct CLLocationCoordinate2D {
    public var latitude: CLLocationDegrees
    public var longitude: CLLocationDegrees
    public init() {
        latitude = 0
        longitude = 0
    }
    
    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

open class CLLocation: NSObject {
    public fileprivate(set) var coordinate: CLLocationCoordinate2D
    public fileprivate(set) var altitude: CLLocationDistance = 0
    public fileprivate(set) var horizontalAccuracy: CLLocationAccuracy = 0
    public fileprivate(set) var verticalAccuracy: CLLocationAccuracy = 0
    public fileprivate(set) var timestamp  = Date()
    public fileprivate(set) var speed: CLLocationSpeed = 0
    public fileprivate(set) var course: CLLocationDirection = 0
    
    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, timestamp: Date) {
        
        self.coordinate = coordinate
        self.altitude = altitude
        self.horizontalAccuracy = hAccuracy
        self.verticalAccuracy = vAccuracy
        self.timestamp = timestamp
    }
    
    public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, course: CLLocationDirection, speed: CLLocationSpeed, timestamp: Date) {
        
        self.coordinate = coordinate
        self.altitude = altitude
        self.horizontalAccuracy = hAccuracy
        self.verticalAccuracy = vAccuracy
        self.course = course
        self.speed = speed
        self.timestamp = timestamp
    }
    
    public func distanceFromLocation(_ location: CLLocation) -> CLLocationDistance {
        let R = 6371000.0;
        let dLat = (coordinate.latitude - location.coordinate.latitude) * M_PI/180.0
        let dLon = (coordinate.longitude - location.coordinate.longitude) * M_PI/180.0
        let lat1 = location.coordinate.latitude * M_PI/180.0
        let lat2 = coordinate.longitude * M_PI/180.0
        
        // Had to break it down as compiler was complaining that it was too complex
        let a1 = sin(dLat/2.0) * sin(dLat/2.0)
        let a2 = sin(dLon/2.0) * sin(dLon/2.0) * cos(lat1) * cos(lat2)
        let a = a1 + a2;
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        let d = R * c;
        return d
    }
}
