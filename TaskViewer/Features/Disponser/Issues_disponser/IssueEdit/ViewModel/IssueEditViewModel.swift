import Foundation
import SwiftUI

protocol IssueEditViewModelProtocol {
    var task: Task {get set}
    
    func addPickedPerformer(performer: Performer)
    func deletePickedPerformer(performer: Performer)
    func saveUpdates(title: String, description: String, steps: [Step], performers: [Performer], disponcer: Disponser,currentStep: Int, isConsistenly: Bool, creationDate: Date, lastEditDate: Date)
}

enum ActiveSheet {
    case cancelTask
    case completeTask
    case completeStep
}

final class IssueEditViewModel: ObservableObject, IssueEditViewModelProtocol {
    
    @Published var task: Task
    
    @Published var storedPerformers: [Performer] = constatntPerformers
    
    @Published var storedDisponser: Disponser = constantDisponcer
    
    @Published var performers: [Performer] = []
    
    @Published var trackTask: [Task] = constantTrackTasks
    
    @Published var TitleTextField = ""
    @Published var DescriptionTextField = ""
    @Published var isConsistenly = false
    
    @Published var stepsInfo: [Step] = [Step(title: "", description: "", status: .inProgress)]
    
    @Published var isEditable: Bool = false
    
    @Published var DescriptionSizes: [CGSize] = []
    @Published var isTrack: Bool = false
    
    @Published var initTask: Task?
    
    @Published var showSheet = false
    @Published var activeSheet: ActiveSheet = .cancelTask
    
    @Published var startAnimationStepImage = false
    
    @Published var indexOfTouchedStep: Int = 0
    
    init (task: Task) {
        self.task = task
        self.initTask = task
        self._performers = Published(initialValue: task.performers)
        DescriptionSizes = self.getArrayOfSizes(array: stepsInfo)
        
        self.TitleTextField = task.title
        self.DescriptionTextField =  task.description
        self.isConsistenly =  task.isСonsistently
        self.stepsInfo =  task.steps
        self.DescriptionSizes = getArrayOfSizes(array: self.stepsInfo)
        
    }
    
    lazy var performersToPick: [Performer] = {
        var toPick = storedPerformers
        performers.forEach({ performer in
            if toPick.contains(where: { performer == $0 }) {
                toPick.remove(at: toPick.firstIndex(of: performer)!)
            }
        })
        return toPick
    }()
    
    func addPickedPerformer(performer: Performer) {
        performersToPick.remove(at: performersToPick.firstIndex(of: performer)!)
        performers.append(Performer(gender: performer.gender,
                                    dateOfBirth: performer.dateOfBirth,
                                    name: performer.name,
                                    surname: performer.surname,
                                    position: performer.position,
                                    imageName: performer.imageName,
                                    mail: performer.mail,
                                    password: performer.password))
    }

    func deletePickedPerformer(performer: Performer) {
        performers.remove(at: performers.firstIndex(of: performer)!)
        performersToPick.append(performer)
    }
    
    func saveUpdates(title: String, description: String, steps: [Step], performers: [Performer], disponcer: Disponser,currentStep: Int, isConsistenly: Bool, creationDate: Date, lastEditDate: Date) {
        let task = Task(title: title,
                        description: description,
                        steps: steps,
                        performers: performers,
                        disponser: disponcer,
                        currentStep: currentStep,
                        isСonsistently: isConsistenly,
                        creationDate: creationDate,
                        lastEditDate: lastEditDate,
                        status: .inProgress)
        self.task = task
    }
    
    func getArrayOfSizes(array: [Step]) -> [CGSize] {
        var sizes: [CGSize] = []
        array.indices.forEach({ _ in
            sizes.append(CGSize(width: 20, height: 20))
        })
        return sizes
    }
    
    func calculateHeight(height: CGFloat) -> CGFloat {
        height < 60 ? 50 : height - 20
    }
}
