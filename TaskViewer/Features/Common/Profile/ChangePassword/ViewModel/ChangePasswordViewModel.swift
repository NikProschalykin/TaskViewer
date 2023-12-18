import Foundation

final class ChangePasswordViewModel: ObservableObject {
    var user: any UserModelProtocol
    var oldPassword: String
    @Published var newPassword: String = ""
    @Published var reenterPassword: String = ""
    @Published var isShowNewPassword: Bool = false
    @Published var isShowReenterPassword: Bool = false
    @Published var errorMessages: [String] = []
    @Published var passwordIsValid = false
    @Published var showingAlert = false
    
    init(user: any UserModelProtocol) {
        self.user = user
        self.oldPassword = user.password
    }
    
    public func validatePassword() {
        var errors: [String] = []
    
        if newPassword.count < 8 {
            errors.append("Пароль должен содержать не менее 8 букв.")
        }
        if !newPassword.contains(where: { $0.isLowercase }) {
            errors.append("Пароль должен содержать как минимум 1 строчную букву.")
        }
        if !newPassword.contains(where: { $0.isUppercase }) {
            errors.append("Пароль должен содержать как минимум 1 заглавную букву.")
        }
        if !newPassword.contains(where: { $0.isNumber }) {
            errors.append("Пароль должен содержать как минимум 1 цифру.")
        }
        if !newPassword.contains(where: { "!@#$%^&*()_-+=[{]};:'\",<.>/?".contains($0) }) {
            errors.append("Пароль должен содержать как минимум 1 специальный символ.")
        }
        
        if newPassword != reenterPassword {
            errors.append("Пароли не совпадают")
        }
        errorMessages = errors
    passwordIsValid = errors.isEmpty
    }
    
    public func saveNewPassword() {
        // TODO: Save new password
        // user.password = newPassword
    }
}
