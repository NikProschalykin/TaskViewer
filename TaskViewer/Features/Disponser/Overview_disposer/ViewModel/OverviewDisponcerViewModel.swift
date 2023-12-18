import Foundation

final class OverviewDisponcerViewModel: ObservableObject {
    @Published var trackedPerformers: [Performer] = constatntPerformers
    @Published var trackedTasks: [Task] = constantTasks
    @Published var lastUpdatedTasks: [Task] = constantTasks
    
    //@Published var tasksList: [String]
    @Published var isTrackedPerformersPresented: Bool = true
    @Published var isTrackedTasksPresented: Bool = true
    @Published var isLastEditPresented: Bool = true
}
