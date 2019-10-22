//
//  File.swift
//  
//
//  Created by Lukas Schmidt on 14.10.19.
//

import GTFS
import Foundation

public struct CombinedTrip {
    public var trip: Trip
    public var stops: [Stop]
    public var stopTimes: [StopTime]
    
    public init(trip: Trip, stopTimes: [StopTime], stops: [Stop]) {
        self.trip = trip
        self.stopTimes = stopTimes.filter { $0.tripId == trip.id }
        self.stops = stopTimes.map { time in
            stops.first(where: { stop in
                stop.id == time.stopId
            })!
        }
    }
}
