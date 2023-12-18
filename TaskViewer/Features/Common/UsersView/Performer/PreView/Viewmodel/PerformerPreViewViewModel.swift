import Foundation
import SwiftUI

final class PerformerPreViewViewModel: TasksCardsViewModelProtocol {
    
    let performer: Performer
    
    internal var storedTasks: [Task] = constantTasks
    
    @Published var storedTrackPerformers = constantTrackPerformers
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
}





