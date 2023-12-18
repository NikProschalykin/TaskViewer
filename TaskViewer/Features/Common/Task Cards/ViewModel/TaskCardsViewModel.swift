import Foundation

final class TaskCardsViewModel: ObservableObject {
    let storedTasks: [Task] = constantTasks
    
    public lazy var sortedTasks: [Task] = {
        return UserSettings.shared.user is Admin ? storedTasks : sortTasks(tasks: storedTasks)
    }()
    
    private func sortTasks(tasks: [Task]) -> [Task] {
        var sortedTasks: [Task] = []
        let user = UserSettings.shared.user
        
        sortedTasks = constantTasks.filter({
            $0.performers.contains(where: {
                (($0.name == user.name) && ($0.surname == user.surname) && ($0.position == user.position))
            })
        })
        
        return sortedTasks
    }
}

