import Foundation

final class DisponcerPreViewViewModel: ObservableObject {
    
    let disponcer: Disponser
    
    internal var storedTasks: [Task] = CoreDataController.shared.fetchAllTasks()
    
    lazy var filtredTasks: [Task] = {
        storedTasks.filter({ $0.disponser.name == disponcer.name &&  $0.disponser.surname == disponcer.surname && $0.disponser.position == disponcer.position})
    }()
    
    init(disponcer: Disponser) {
        self.disponcer = disponcer
    }
    
    
}
