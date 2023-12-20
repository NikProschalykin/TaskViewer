import Foundation

final class GodCoordinator: ObservableObject {

    public func sendNotification(title: String, description: String, user: any UserModelProtocol) {
        let notification = AppNotification(title: title,
                                           decription: description,
                                           status: .unseen,
                                           user: user)
        
        CoreDataController.shared.createNotification(notification: notification)
    }
}
