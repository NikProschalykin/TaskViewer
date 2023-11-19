import Foundation

protocol TaskProtocol {
    var title: String { get set }
    var description: String { get set }
    var steps: [Step] { get set }
    var performers: [Performer] { get set }
    var disponser: [Disponser] { get set }
    var currentStep: Int { get set }
    var isСonsistently: Bool { get set }
}

struct Task: Hashable, TaskProtocol {
    var title: String
    var description: String
    var steps: [Step]
    var performers: [Performer]
    var disponser: [Disponser]
    var currentStep: Int
    
//    var start: Date? {
//        return steps.min(by: {
//            guard let a = $0.start, let b = $1.start else { return false }
//            return a < b
//        })?.start
//    }
//
//    var finish: Date? {
//        return steps.max(by: {
//            guard let a = $0.finish, let b = $1.finish else { return false }
//            return a < b
//        })?.finish
//    }
    
    var isСonsistently: Bool
}

struct Step: Hashable {
    var title: String
    var description: String
}

struct Performer: Hashable {
    var name: String
    var surname: String
    var position: String
}

struct Disponser: Hashable  {
    var name: String
    var surname: String
    var position: String
}

struct Admin: Hashable  {
    var name: String
    var surname: String
    var position: String
}
