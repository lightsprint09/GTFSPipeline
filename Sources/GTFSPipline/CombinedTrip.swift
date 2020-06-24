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
    
    public init(trip: Trip, stopTimes: [StopTime], stops: [Stop]) throws {
        self.trip = trip
        self.stopTimes = stopTimes.filter { $0.tripId == trip.id }
        self.stops = try self.stopTimes.map { time in
            guard let stop = stops.first(where: { stop in
                stop.id == time.stopId
            }) else {
                throw NSError(domain: "Could not find stop with id \(time.stopId)", code: 0, userInfo: ["tripshortName": trip.shortName ?? ""])
            }
            return stop
        }
    }
}
