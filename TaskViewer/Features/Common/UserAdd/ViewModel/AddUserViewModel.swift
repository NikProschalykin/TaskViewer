import Foundation

final class AddUserViewModel: ObservableObject {
    
    @Published var gender: Gender = .male
    @Published var dateOfBirth: Date = Date()
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var position: String = ""
    @Published var mail: String = ""
    @Published var password: String = ""
    
    //TODO: Add to DB
    func addUser(user role: UserRole) {
        switch role {
        case .performer:
            Performer(gender: gender,
                      dateOfBirth: dateOfBirth,
                      name: name,
                      surname: surname,
                      position: position,
                      imageName: "Empty",
                      mail: mail,
                      password: password)
        case .disposer:
            Disponser(gender: gender,
                      dateOfBirth: dateOfBirth,
                      name: name,
                      surname: surname,
                      position: position,
                      imageName: "Empty",
                      mail: mail,
                      password: password)
        default: return
        }
    }
}
