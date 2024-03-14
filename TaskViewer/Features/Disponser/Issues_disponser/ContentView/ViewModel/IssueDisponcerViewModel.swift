import Foundation
import SwiftUI

final class IssueDisponcerViewModel: ObservableObject {
    
  @Published var storedTasks: [Task] = []
  @Published var storedTasksCancelled: [Task] = []
  @Published var storedTasksCompleted: [Task] = []
    
    public func loadTasks() {
        storedTasks = CoreDataController.shared.fetchAllTasks().filter({ $0.status == .inProgress })
        storedTasksCancelled = CoreDataController.shared.fetchAllTasks().filter({ $0.status == .canceled })
        storedTasksCompleted = CoreDataController.shared.fetchAllTasks().filter({ $0.status == .completed })
    }
}
