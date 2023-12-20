import SwiftUI

final class PerformerContentViewViewModel: ObservableObject {
    @Published var progressTasks: [Task] = []
    @Published var completedTasks: [Task] = []
    @Published var canceledTasks: [Task] = []
    
    func loadTasks() {
        self.progressTasks = CoreDataController.shared.fetchAllTasks().filter({ $0.status == .inProgress }).filter({ $0.performers.contains(where: { $0.id == UserSettings.shared.user.id }) })
        self.completedTasks = CoreDataController.shared.fetchAllTasks().filter({ $0.status == .completed }).filter({ $0.performers.contains(where: { $0.id == UserSettings.shared.user.id }) })
        self.canceledTasks = CoreDataController.shared.fetchAllTasks().filter({ $0.status == .canceled }).filter({ $0.performers.contains(where: { $0.id == UserSettings.shared.user.id }) })
    }
}
