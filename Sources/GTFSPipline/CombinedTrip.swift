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
    public var times: [StopTime]
    
    init(trip: Trip, stopTimes: [StopTime], stops: [Stop]) {
        self.trip = trip
        self.times = stopTimes.filter { $0.tripId == trip.id }
        self.stops = times.map { time in stops.first(where: { $0.id == time.stopId })! }
    }
}
