import SwiftUI

final class PerformerContentViewViewModel: ObservableObject {
    @Published var progressTasks: [Task] = constantTasks
    @Published var completedTasks: [Task] = constantCompletedTasks
    @Published var canceledTasks: [Task] = constantCanceledTasks
}
