//
//  CLLocation.swift
//  CoreLinuxLocation
//
//  Created by Jimmy Chan on 4/23/16.
//  Copyright © 2016 Projek J. All rights reserved.
//

import Foundation

public typealias CLLocationDegrees = Double
public typealias CLLocationAccuracy = Double
public typealias CLLocationDistance = Double
public typealias CLLocationSpeed = Double
public typealias CLLocationDirection = Double

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
    public func distance(_ fromCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let R = 6371000.0;
        let dLat = (self.latitude - fromCoordinate.latitude) * M_PI/180.0
        let dLon = (self.longitude - fromCoordinate.longitude) * M_PI/180.0
        let lat1 = fromCoordinate.latitude * M_PI/180.0
        let lat2 = self.longitude * M_PI/180.0
        
        // Had to break it down as compiler was complaining that it was too complex
        let a1 = sin(dLat/2.0) * sin(dLat/2.0)
        let a2 = sin(dLon/2.0) * sin(dLon/2.0) * cos(lat1) * cos(lat2)
        let a = a1 + a2;
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        let d = R * c;
        return d
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
    
    public func distance(from location: CLLocation) -> CLLocationDistance {
        return self.coordinate.distance(location.coordinate)
    }

}

public func CLLocationCoordinate2DIsValid(_ coord: CLLocationCoordinate2D) -> Bool {
    guard coord.latitude < 90.0 && coord.latitude > -90.0 else {
        return false
    }
    guard coord.longitude < 180.0 && coord.longitude > -180.0 else {
        return false
    }
    return true
}

