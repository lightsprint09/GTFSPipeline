struct GTFSPipline {
    var text = "Hello, World!"
}

public protocol Step {
    
    init(gtfs: GFTFSPackages)
    
    var name: String { get }
    
    var required: [FileType] { get }

    var produces: [FileType] { get }
    
    func execute(completion: @escaping (Result<StepResult, Error>) -> Void)
    
    
}

public struct StepResult: Codable {
    public let result: GFTFSPackages
    public let warnings: [String]
    public var descriptions: [String]
}

class Pipline {
    
    init(steps: [Step])
    
    func execute(completion: @escaping (Result<[(name: String, StepResult)], Error>) -> Void) {
        
        
    }
    
}
