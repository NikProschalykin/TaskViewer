import Foundation
import SwiftUI

protocol AppNotificationProtocol: Hashable, Equatable {
    var id: UUID { get }
}

struct AppNotification: AppNotificationProtocol {
    static func == (lhs: AppNotification, rhs: AppNotification) -> Bool {
        (lhs.id == rhs.id)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: UUID = UUID()
    let title: String
    let decription: String
    let date: Date = Date()
    let status: NotificationStatus
    let user: any UserModelProtocol
}
