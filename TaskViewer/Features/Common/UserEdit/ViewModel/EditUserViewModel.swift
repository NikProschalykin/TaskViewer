import Foundation
import SwiftUI

final class EditUserViewModel: ObservableObject {
    
    var user: any UserModelProtocol
    
    @Published var gender: Gender = .male
    @Published var dateOfBirth: Date = Date()
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var position: String = ""
    @Published var mail: String = ""
    @Published var password: String = ""
    
    init(user: any UserModelProtocol) {
        self.user = user
        
        self.gender = user.gender
        self.dateOfBirth = user.dateOfBirth
        self.name = user.name
        self.surname = user.surname
        self.position = user.position
        self.mail = user.mail
        self.password = user.password
    }
    
    //TODO: Save to DB
    func updateUser() {
        user.gender  = gender
        user.dateOfBirth = dateOfBirth
        user.name = name
        user.surname = surname
        user.position = position
        user.mail = mail
        user.password = password
        
        CoreDataController.shared.updateUser(for: user.id, user: user)
    }
}
