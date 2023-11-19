import Foundation
import SwiftUI

protocol CreateIssueViewModelProtocol {
    var performers: [Performer] { get set }
    
    func addPickedPerformer(performer: Performer)
    func deletePickedPerformer(performer: Performer)
    func createTask(title: String, description: String, steps: [Step], performers: [Performer], disponcers: [Disponser], isConsistenly: Bool)
}

final class CreateIssueViewModel: ObservableObject, CreateIssueViewModelProtocol {
    
    @Published var storedTasks: [Task] = [
    
    Task(title: "Emprove security", description: "Emprove secury by adding PQC", steps: [
    
        Step(title: "Add pqc-alorythms", description: "Crystal-Kyber"),
        Step(title: "add pqc to tls", description: "cloudfire for tests")
        
    ], performers: [
    
        Performer(name: "Eric", surname: "Swift", position: "IOS-developer"),
    
    ], disponser: [
        
        Disponser(name: "Otis", surname: "Cooper", position: "Mobile-teamLead"),
        
    ], currentStep: 2, isСonsistently: true)
    
    ]
    
    @Published var storedPerformers: [Performer] = [
        
        Performer(name: "Eric", surname: "Swift", position: "IOS-developer"),
        Performer(name: "Clara", surname: "Go", position: "Backend-developer"),
        Performer(name: "Henry", surname: "Python", position: "data-sientist"),
        Performer(name: "Mark", surname: "Javac", position: "Big Data-developer"),
        Performer(name: "Hellen", surname: "Pascal", position: "QA"),
        Performer(name: "Poly", surname: "Scetch", position: "Designer"),
        
    ]
    
    @Published var storedDisponser: [Disponser] = [
        
        Disponser(name: "Otis", surname: "Cooper", position: "Mobile-teamLead"),
        Disponser(name: "Kate", surname: "Bishop", position: "Web-teamLead"),
        Disponser(name: "Sarra", surname: "Konor", position: "TechLead"),
    
    ]
    
    @Published var performers: [Performer] = []
    
    lazy var performersToPick: [Performer] = storedPerformers
    
    func addPickedPerformer(performer: Performer) {
        performersToPick.remove(at: performersToPick.firstIndex(of: performer)!)
        performers.append(Performer(name: performer.name, surname: performer.surname, position: performer.position))
    }
    
    func deletePickedPerformer(performer: Performer) {
        performers.remove(at: performers.firstIndex(of: performer)!)
        performersToPick.append(performer)
    }
    
    func createTask(title: String, description: String, steps: [Step], performers: [Performer], disponcers: [Disponser], isConsistenly: Bool) {
        storedTasks.append(Task(title: title,
                                description: description,
                                steps: steps,
                                performers: performers,
                                disponser: disponcers, currentStep: 1,
                                isСonsistently: isConsistenly))
    }
}
