import Foundation
import SwiftUI

final class PerformerPreViewViewModel: ObservableObject {
    
    let performer: Performer
    
    internal var storedTasks: [Task] = CoreDataController.shared.fetchAllTasks().filter({ $0.status == .inProgress })
    
    @Published var isTrack: Bool = false
    
    lazy var filtredTasks: [Task] = {
        storedTasks.filter({
            $0.performers.contains(where: {
                (($0.name == performer.name) && ($0.surname == performer.surname) && ($0.position == performer.position))
            })
        })
    }()
    
    init(performer: Performer) {
        self.performer = performer
        self._isTrack = Published(initialValue: checkIsTrack())
    }
    
    func getFormattedPerformers(task: Task) -> String {
        var str = ""
        
        task.performers.forEach({ performer in
            str += "\(performer.name),"
        })
        str.removeLast()
        
        return str
    }
    
    func getFormattedDisponcers(task: Task) -> String {
        task.disponser.name
    }
    
    func addToTrack() {
        let disponcer = UserSettings.shared.user as! Disponser
        
        if CoreDataController.shared.fetchTrackPerformers(to: disponcer) == nil {
            CoreDataController.shared.createTrackPerformer(disponcer: disponcer)
        }
        CoreDataController.shared.addToTrackPerformer(to: disponcer, of: performer)
    }
    
    func removeFromTrack() {
        let disponcer = UserSettings.shared.user as! Disponser
        
        CoreDataController.shared.removeFromTrackPerformer(to: disponcer, of: performer)
    }
    
    private func checkIsTrack() -> Bool {
      if CoreDataController.shared.fetchTrackPerformers(to: UserSettings.shared.user)?.first(where: { performer in
            performer.id == self.performer.id
      }) == nil { return false } else { return true }
    }
}





