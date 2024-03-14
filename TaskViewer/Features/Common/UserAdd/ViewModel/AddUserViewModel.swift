import Foundation
import SwiftUI
import CoreData

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
            let performer = Performer(gender: gender,
                      dateOfBirth: dateOfBirth,
                      name: name,
                      surname: surname,
                      position: position,
                      imageName: "Empty",
                      mail: mail,
                      password: password)
            CoreDataController.shared.createUser(user: performer)
        case .disposer:
            let disponcer = Disponser(gender: gender,
                      dateOfBirth: dateOfBirth,
                      name: name,
                      surname: surname,
                      position: position,
                      imageName: "Empty",
                      mail: mail,
                      password: password)
            CoreDataController.shared.createUser(user: disponcer)
            
        case .admin:
            let admin = Admin(gender: gender,
                              dateOfBirth: dateOfBirth,
                              name: name,
                              surname: surname,
                              position: position,
                              imageName: "Empty",
                              mail: mail,
                              password: password)
            
            CoreDataController.shared.createUser(user: admin)
        }
    }
}
