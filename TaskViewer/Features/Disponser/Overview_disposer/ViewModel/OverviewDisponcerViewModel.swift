import Foundation

final class OverviewDisponcerViewModel: ObservableObject {
    @Published var trackedPerformers: [Performer] = []
    @Published var trackedTasks: [Task] = []
    @Published var lastUpdatedTasks: [Task] = []
    
    @Published var isTrackedPerformersPresented: Bool = true
    @Published var isTrackedTasksPresented: Bool = true
    @Published var isLastEditPresented: Bool = false
    
    public func loadCardsArray() {
        self.trackedPerformers = (CoreDataController.shared.fetchTrackPerformers(to: UserSettings.shared.user) ?? [])
        self.trackedTasks = (CoreDataController.shared.fetchTrackTask(to: UserSettings.shared.user) ?? []).filter({ $0.status == .inProgress })
        self.lastUpdatedTasks = (CoreDataController.shared.fetchAllTasks()).filter({ $0.lastEditDate?.isWithinLastSevenDays() ?? false })
    }
}


// поля
// поэтапное выполнение
