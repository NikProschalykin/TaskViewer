import Foundation

final class NotificationsViewModel: ObservableObject {
    
    @Published var storedNotifications: [AppNotification] =  variableNotifications
    
    public lazy var sortedNotifications: [AppNotification] = {
        return sortNotifications(notifications: storedNotifications)
    }()
    
    private func sortNotifications(notifications: [AppNotification]) -> [AppNotification] {
        var sortedNotifications: [AppNotification] = []
          
        sortedNotifications += storedNotifications.filter{ notification in
            (notification.user.name == UserSettings.shared.user.name) && (notification.user.surname == UserSettings.shared.user.surname) && (notification.user.position == UserSettings.shared.user.position) && notification.status == .unseen
        }
        sortedNotifications += storedNotifications.filter{ notification in
            (notification.user.name == UserSettings.shared.user.name) && (notification.user.surname == UserSettings.shared.user.surname) && (notification.user.position == UserSettings.shared.user.position) && notification.status == .seen
        }
        
        dump(variableNotifications)
        return sortedNotifications
    }
}
