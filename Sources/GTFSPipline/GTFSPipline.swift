import Foundation

public protocol Step {
        
    var name: String { get }
    
    var required: [FileType] { get }

    var produces: [FileType] { get }
    
    func execute(completion: @escaping (Result<StepResult, Error>) -> Void)
    
}

public extension Step {
    var name: String {
        return String(describing: self)
    }
}

public struct StepResult: Codable {
    public let stepName: String
    public let gtfs: GTFSPackages
    public let warnings: [String]
    public var descriptions: [String]
    
    public init(stepName: String, gtfs: GTFSPackages, warnings: [String], descriptions: [String] = []) {
        self.stepName = stepName
        self.gtfs = gtfs
        self.warnings = warnings
        self.descriptions = descriptions
    }
}

public func write(_ result: StepResult, to url: URL) {
    let dataPath = url.appendingPathComponent(result.stepName)

    do {
        try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        print("Error creating directory: \(error.localizedDescription)")
    }
    
    write(url: url, stepName: result.stepName, fileName: "Routes", content: result.gtfs.routes)
    write(url: url, stepName: result.stepName, fileName: "Trips", content: result.gtfs.trips)
    write(url: url, stepName: result.stepName, fileName: "Stops", content: result.gtfs.stops)
    write(url: url, stepName: result.stepName, fileName: "Shapes", content: result.gtfs.shapes)
    write(url: url, stepName: result.stepName, fileName: "StopTimes", content: result.gtfs.stopTimes)
    write(url: url, stepName: result.stepName, fileName: "Warnings", content: result.warnings)
    write(url: url, stepName: result.stepName, fileName: "Descriptions", content: result.descriptions)
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
