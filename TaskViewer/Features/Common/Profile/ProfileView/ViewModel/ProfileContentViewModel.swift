import Foundation

final class ProfileContentViewModel: ObservableObject {
    let user = UserSettings.shared.user
    @Published var presentSheet: Bool = false
}
