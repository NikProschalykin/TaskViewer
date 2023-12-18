import Foundation
import SwiftUI

struct AppNotification: Hashable {
    static func == (lhs: AppNotification, rhs: AppNotification) -> Bool {
        (lhs.id == rhs.id)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    let title: String
    let decription: String
    let date: Date = Date()
    let status: NotificationStatus
    let user: any UserModelProtocol
}
