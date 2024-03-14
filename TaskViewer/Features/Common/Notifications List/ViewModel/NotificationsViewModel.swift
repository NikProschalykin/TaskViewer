import Foundation

final class NotificationsViewModel: ObservableObject {
    
    @Published var sortedNotifications: [AppNotification] = []
    
    private func sortNotifications(notifications: [AppNotification]) -> [AppNotification] {
        var sortedNotifications: [AppNotification] = []
          
        sortedNotifications += notifications.filter{ notification in
            (notification.user.name == UserSettings.shared.user.name) && (notification.user.surname == UserSettings.shared.user.surname) && (notification.user.position == UserSettings.shared.user.position) && notification.status == .unseen
        }
        sortedNotifications += notifications.filter{ notification in
            (notification.user.name == UserSettings.shared.user.name) && (notification.user.surname == UserSettings.shared.user.surname) && (notification.user.position == UserSettings.shared.user.position) && notification.status == .seen
        }
        
        return sortedNotifications
    }
    
    func loadNotifications() {
        sortedNotifications = sortNotifications(notifications: CoreDataController.shared.fetchAllNotifications())
    }
    
    func seenNotifications() {
        sortedNotifications.forEach { notification in
            CoreDataController.shared.updateNotificationStatus(for: notification.id, status: .seen)
        }
    }
}
