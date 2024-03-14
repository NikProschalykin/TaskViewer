import Foundation
import SwiftUI

protocol IssueEditViewModelProtocol {
    var task: Task {get set}
    
    func addPickedPerformer(performer: Performer)
    func deletePickedPerformer(performer: Performer)
}

enum ActiveSheet {
    case cancelTask
    case completeTask
    case completeStep
}

final class IssueEditViewModel: ObservableObject, IssueEditViewModelProtocol {
    
    @Published var task: Task
    
    @Published var storedPerformers: [Performer] = CoreDataController.shared.fetchPerformers()
    
    @Published var performers: [Performer] = []
    
    @Published var TitleTextField = ""
    @Published var DescriptionTextField = ""
    @Published var isConsistenly = false
    
    @Published var stepsInfo: [Step] = [Step(id: UUID(),title: "", description: "", status: .inProgress)]
    
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
        self._isTrack = Published(initialValue: checkIsTrack())
    }
    
    private func checkIsTrack() -> Bool {
      if CoreDataController.shared.fetchTrackTask(to: UserSettings.shared.user)?.first(where: { task in
            task.id == self.task.id
      }) == nil { return false } else { return true }
    }
    
    func addToTrack() {
        let disponcer = UserSettings.shared.user as! Disponser
        
        if CoreDataController.shared.fetchTrackTask(to: disponcer) == nil {
            CoreDataController.shared.createTrackTask(disponcer: disponcer)
        }
        CoreDataController.shared.addToTrackTask(to: disponcer, task: self.task)
    }
    
    func removeFromTrack() {
        let disponcer = UserSettings.shared.user as! Disponser
        
        CoreDataController.shared.removeFromTrackTask(to: disponcer, task: self.task)
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
        performers.append(performer)
    }

    func deletePickedPerformer(performer: Performer) {
        performers.remove(at: performers.firstIndex(of: performer)!)
        performersToPick.append(performer)
    }
    
    func saveUpdates() {
        let task = Task(id: task.id,
                         title: TitleTextField,
                         description: DescriptionTextField,
                         steps: stepsInfo,
                         performers: performers,
                        disponser: task.disponser,
                         currentStep: task.currentStep,
                         isСonsistently: isConsistenly,
                         creationDate: task.creationDate,
                         lastEditDate: Date(),
                         status: task.status)
        
        CoreDataController.shared.updateTask(for: task.id, task: task)
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
