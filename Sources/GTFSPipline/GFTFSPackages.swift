//
//  File.swift
//  
//
//  Created by Lukas Schmidt on 14.10.19.
//

import Foundation
import GTFS

public struct GFTFSPackages: Codable {
    public var routes: [Route]?
    public var trips: [Trip]?
    public var stops: [Stop]?
    public var stopTimes: [StopTime]?
    
    init(routes: [Route]? = nil, trips: [Trip]? = nil, stops: [Stop]? = nil, stopTimes: [StopTime]? = nil) {
        self.routes = routes
        self.trips = trips
        self.stops = stops
        self.stopTimes = stopTimes
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
            }
        })
    }
}

public enum FileType {
    case routes
    case trips
    case stops
    case stopTimes
}
