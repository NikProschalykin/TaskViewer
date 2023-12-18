import Foundation
import SwiftUI

protocol TasksCardsViewModelProtocol: ObservableObject {
   var storedTasks: [Task] { get set }
}

final class IssueDisponcerViewModel: TasksCardsViewModelProtocol {
    
    var storedTasks: [Task] = constantTasks
    var storedTasksCancelled: [Task] = constantCanceledTasks
    var storedTasksCompleted: [Task] = constantCompletedTasks
}
