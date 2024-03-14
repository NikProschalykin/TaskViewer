import Foundation

final class LogInViewModel: ObservableObject {
    @Published var login = ""
    @Published var password = ""
    
    @Published var isShowPassword = false
    
    @Published var isPerformerExist = false
    
    @Published var showError = false
    @Published var showProfiles = false
    
    func logInbyAdmin() {
        UserSettings.shared.user = CoreDataController.shared.fetchAdmins().first!
    }
    
    func logInByPerformer() {
        UserSettings.shared.user = CoreDataController.shared.fetchPerformers().first!
    }
    
    func logInByDisponcer() {
        UserSettings.shared.user = CoreDataController.shared.fetchDisponcers().first!
    }
    
    func LogIn() -> Bool {
        guard let CdUser = CoreDataController.shared.fetchUser(by: login, and: password) else { showError = true ;return false}
        showError = false
        UserSettings.shared.user = CoreDataController.shared.fetchUserModelProtocolUser(by: CdUser.id!)!
        return true
    }
}
