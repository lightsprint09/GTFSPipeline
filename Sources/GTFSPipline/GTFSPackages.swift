//
//  File.swift
//  
//
//  Created by Lukas Schmidt on 14.10.19.
//

import Foundation
import GTFS

public struct GTFSPackages: Codable {
    public var routes: [Route]?
    public var trips: [Trip]?
    public var stops: [Stop]?
    public var stopTimes: [StopTime]?
    public var shapes: [Shape]?
    
    public init(routes: [Route]? = nil, trips: [Trip]? = nil, stops: [Stop]? = nil, stopTimes: [StopTime]? = nil, shapes: [Shape]? = nil) {
        self.routes = routes
        self.trips = trips
        self.stops = stops
        self.stopTimes = stopTimes
        self.shapes = shapes
    }
    
    func matches(filesTypes: [FileType]) -> Bool {
        return filesTypes.reduce(true, { matches, type in
            switch type {
            case .routes:
                return matches && routes != nil
            case .trips:
                return matches && trips != nil
            case .stops:
                return matches && stops != nil
            case .stopTimes:
                return matches && stopTimes != nil
            case .shapes:
                return matches && shapes != nil
            }
        })
    }
}

public enum FileType {
    case routes
    case trips
    case stops
    case stopTimes
    case shapes
}
