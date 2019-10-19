import Foundation

public protocol Step {
    
    init(gtfs: GFTFSPackages)
    
    var name: String { get }
    
    var required: [FileType] { get }

    var produces: [FileType] { get }
    
    func execute(completion: @escaping (Result<StepResult, Error>) -> Void)
    
}

public struct StepResult: Codable {
    public let stepName: String
    public let gtfs: GFTFSPackages
    public let warnings: [String]
    public var descriptions: [String]
    
    public init(stepName: String, gtfs: GFTFSPackages, warnings: [String], descriptions: [String] = []) {
        self.stepName = stepName
        self.gtfs = gtfs
        self.warnings = warnings
        self.descriptions = descriptions
    }
}

public func write(_ result: StepResult, to url: URL) {
    write(url: url, stepName: result.stepName, fileName: "Routes", content: result.gtfs.routes)
    write(url: url, stepName: result.stepName, fileName: "Trips", content: result.gtfs.trips)
    write(url: url, stepName: result.stepName, fileName: "Stops", content: result.gtfs.stops)
    write(url: url, stepName: result.stepName, fileName: "StopTimes", content: result.gtfs.stopTimes)
}

private func write<T: Codable>(url: URL, stepName: String, fileName: String, content: T) {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    
    let urlPath = url.appendingPathComponent("\(stepName)/\(fileName).json")
    let data = try! jsonEncoder.encode(content)
    try! data.write(to: urlPath)
    
}


//class Pipline {
//
//    init(steps: [Step])
//
//    func execute(completion: @escaping (Result<[(name: String, StepResult)], Error>) -> Void) {
//
//
//    }
//
//}
