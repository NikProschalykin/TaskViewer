import Foundation
import SwiftUI

protocol CreateIssueViewModelProtocol {
    var performers: [Performer] { get set }
    
    func addPickedPerformer(performer: Performer)
    func deletePickedPerformer(performer: Performer)
    func createTask(title: String, description: String, steps: [Step], performers: [Performer], disponcer: Disponser, isConsistenly: Bool)
}

final class CreateIssueViewModel: ObservableObject, CreateIssueViewModelProtocol {
    
    @Published var storedTasks: [Task] = constantTasks
   
    @Published var storedPerformers: [Performer] = [
        
        Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
        Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
        Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
        
    ]
    
    @Published var storedDisponser: [Disponser] = [
        
        Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
        Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
        Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
    
    ]
    
    @Published var performers: [Performer] = []
    
    lazy var performersToPick: [Performer] = storedPerformers
    
    @Published var TitleTextField = ""
    @Published var DescriptionTextField = ""
    @Published var searchText = ""
    @Published var isConsistenly = false
    
    @Published var stepsInfo: [Step] = [Step(title: "", description: "", status: .inProgress)]
    
    
    func addPickedPerformer(performer: Performer) {
        performersToPick.remove(at: performersToPick.firstIndex(of: performer)!)
        performers.append(Performer(gender: performer.gender, dateOfBirth: performer.dateOfBirth, name: performer.name, surname: performer.surname, position: performer.position, imageName: performer.imageName, mail: performer.mail, password: performer.password))
    }
    
    func deletePickedPerformer(performer: Performer) {
        performers.remove(at: performers.firstIndex(of: performer)!)
        performersToPick.append(performer)
    }
    
    func createTask(title: String, description: String, steps: [Step], performers: [Performer], disponcer: Disponser, isConsistenly: Bool) {
        storedTasks.append(Task(title: title,
                                description: description,
                                steps: steps,
                                performers: performers,
                                disponser: disponcer,
                                currentStep: 1,
                                isСonsistently: isConsistenly,
                                creationDate: Date(),
                                status: .inProgress))
    }
}
