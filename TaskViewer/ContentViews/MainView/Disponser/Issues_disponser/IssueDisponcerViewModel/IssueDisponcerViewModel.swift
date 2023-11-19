import Foundation
import SwiftUI

protocol IssueDisponcerViewModelProtocol {
    var storedTasks: [Task] { get set }
}

final class IssueDisponcerViewModel: ObservableObject, IssueDisponcerViewModelProtocol {
    
    @Published var storedTasks: [Task] = [
    
    Task(title: "Emprove security", description: "Emprove secury by adding PQC", steps: [
    
        Step(title: "Add pqc-alorythms", description: "Crystal-Kyber"),
        Step(title: "add pqc to tls", description: "cloudfire for tests")
        
    ], performers: [
    
        Performer(name: "Eric", surname: "Swift", position: "IOS-developer"),
    
    ], disponser: [
        
        Disponser(name: "Otis", surname: "Cooper", position: "Mobile-teamLead"),
        Disponser(name: "Kate", surname: "Bishop", position: "Web-teamLead"),
        
    ], currentStep: 2, isСonsistently: true),
    
    Task(title: "UI/UX working", description: "make UI of app to friday", steps: [
    
        Step(title: "Make UI", description: "make UI of app to friday")
        
    ], performers: [
    
        Performer(name: "Eric", surname: "Swift", position: "IOS-developer"),
    
    ], disponser: [
        
        Disponser(name: "Otis", surname: "Cooper", position: "Mobile-teamLead"),
        
    ], currentStep: 1, isСonsistently: true),
    
    Task(title: "Emprove security", description: "Emprove secury by adding PQC", steps: [
    
        Step(title: "Add pqc-alorythms", description: "Crystal-Kyber"),
        Step(title: "add pqc to tls", description: "cloudfire for tests")
        
    ], performers: [
    
        Performer(name: "Eric", surname: "Swift", position: "IOS-developer"),
        Performer(name: "Mark", surname: "Javac", position: "Big Data-developer")
        
    
    ], disponser: [
        
        Disponser(name: "Otis", surname: "Cooper", position: "Mobile-teamLead"),
        Disponser(name: "Kate", surname: "Bishop", position: "Web-teamLead"),
        Disponser(name: "Sarra", surname: "Konor", position: "TechLead"),
        
    ], currentStep: 2, isСonsistently: true),
    
    Task(title: "Emprove security", description: "Emprove secury by adding PQC", steps: [
    
        Step(title: "Add pqc-alorythms", description: "Crystal-Kyber"),
        Step(title: "add pqc to tls", description: "cloudfire for tests"),
        Step(title: "Add pqc-alorythms", description: "Crystal-Kyber"),
        Step(title: "add pqc to tls", description: "cloudfire for tests"),
        Step(title: "Add pqc-alorythms", description: "Crystal-Kyber"),
        Step(title: "add pqc to tls", description: "cloudfire for tests"),
        Step(title: "Add pqc-alorythms", description: "Crystal-Kyber"),
        Step(title: "add pqc to tls", description: "cloudfire for tests")
        
    ], performers: [
    
        Performer(name: "Eric", surname: "Swift", position: "IOS-developer"),
        Performer(name: "Hellen", surname: "Pascal", position: "QA"),
        Performer(name: "Poly", surname: "Scetch", position: "Designer"),
    
    ], disponser: [
        
        Disponser(name: "Otis", surname: "Cooper", position: "Mobile-teamLead"),
        
    ], currentStep: 3, isСonsistently: true)
    
    ]
    
    func getFormattedPerformers(task: Task) -> String {
        var str = ""
        
        task.performers.forEach({ performer in
            str += "\(performer.name),"
        })
        str.removeLast()
        
        return str
    }
    
    func getFormattedDisponcers(task: Task) -> String {
        var str = ""
        
        task.disponser.forEach({ disponcer in
            str += "\(disponcer.name),"
        })
        str.removeLast()
        
        return str
    }
    
}
