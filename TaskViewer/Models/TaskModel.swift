import Foundation

protocol TaskProtocol {
    var id: UUID { get set }
    var title: String { get set }
    var description: String { get set }
    var steps: [Step] { get set }
    var performers: [Performer] { get set }
    var disponser: Disponser { get set }
    var currentStep: Int { get set }
    var isСonsistently: Bool { get set }
    var creationDate: Date { get set }
    var lastEditDate: Date? { get set }
    var status: TaskStatus { get set }
}

struct Task: Hashable, TaskProtocol {
    var id: UUID = UUID()
    var title: String
    var description: String
    var steps: [Step]
    var performers: [Performer]
    var disponser: Disponser
    var currentStep: Int
    
    var isСonsistently: Bool
    var creationDate: Date
    var lastEditDate: Date?
    var status: TaskStatus
}

struct Step: Hashable {
    var title: String
    var description: String
    var status: StepStatus
}
