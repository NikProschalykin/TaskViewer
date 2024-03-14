import Foundation

final class UserSettings {
    public static let shared = UserSettings()
    private init() {}
    
    var user: any UserModelProtocol = Unknown()
}
