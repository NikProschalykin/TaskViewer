import Foundation

enum TaskStatus: String {
    case completed = "Выполнено"
    case canceled = "Отменено"
    case inProgress = "Выполняется"
}

enum StepStatus: String {
    case completed = "Выполнено"
    case inProgress = "Выполняется"
}

enum NotificationStatus: String {
    case seen = "Просмотренно"
    case unseen = "Не просмотренно"
}

