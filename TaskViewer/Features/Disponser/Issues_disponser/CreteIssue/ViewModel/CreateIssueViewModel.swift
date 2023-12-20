import Foundation
import SwiftUI

protocol CreateIssueViewModelProtocol {
    var performers: [Performer] { get set }
    
    func addPickedPerformer(performer: Performer)
    func deletePickedPerformer(performer: Performer)
}

final class CreateIssueViewModel: ObservableObject, CreateIssueViewModelProtocol {
    
    //@Published var storedTasks: [Task] = constantTasks
   
    @Published var storedPerformers: [Performer] = CoreDataController.shared.fetchPerformers()
    
    @Published var performers: [Performer] = []
    
    lazy var performersToPick: [Performer] = storedPerformers
    
    @Published var TitleTextField = ""
    @Published var DescriptionTextField = ""
    @Published var searchText = ""
    @Published var isConsistenly = false
    
    @Published var stepsInfo: [Step] = [Step(id: UUID(),title: "", description: "", status: .inProgress)]
    
    
    func addPickedPerformer(performer: Performer) {
        performersToPick.remove(at: performersToPick.firstIndex(of: performer)!)
        performers.append(performer)
    }
    
    func deletePickedPerformer(performer: Performer) {
        performers.remove(at: performers.firstIndex(of: performer)!)
        performersToPick.append(performer)
    }
    
    func createTask() {
        
        let disponcer = CoreDataController.shared.fetchDisponcers().first
        
        let task = Task(id: UUID(),
                        title: TitleTextField,
                        description: DescriptionTextField,
                        steps: stepsInfo,
                        performers: performers,
                        disponser: disponcer!,
                        currentStep: 1,
                        isСonsistently: isConsistenly,
                        creationDate: Date(),
                        status: .inProgress)
        
        CoreDataController.shared.createTask(task: task)
        
        let description = "\(disponcer!.name) \(disponcer!.surname) создал задачу \(TitleTextField)"
        performers.forEach { user in
            GodCoordinator().sendNotification(title: "Создана задача!", description: description, user: user)
        }
        GodCoordinator().sendNotification(title: "Создана задача!", description: description, user: disponcer!)
    }
}
