import Foundation
import SwiftUI

enum Gender: String {
    case male = "Мужчина"
    case female = "Женщина"
}

protocol UserModelProtocol: Hashable, Equatable {
    var id: UUID { get }
    var name: String { get set }
    var surname: String { get set }
    var position: String { get set }
    var imageName: String { get set }
    var gender: Gender { get set }
    var dateOfBirth: Date { get set }
    var mail: String { get set }
    var password: String { get set }
    var role: UserRole { get set }
}

struct Performer: UserModelProtocol  {
    var id: UUID = UUID() 
    var gender: Gender
    var dateOfBirth: Date
    var name: String
    var surname: String
    var position: String
    var imageName: String
    var mail: String
    var password: String
    var role: UserRole = .performer
    
    static func == (lhs: Performer, rhs: Performer) -> Bool {
        (lhs.name == rhs.name) && (lhs.surname == rhs.surname) && (lhs.position == rhs.position)
    }
}

struct Disponser: UserModelProtocol  {
    var id: UUID = UUID()
    var gender: Gender
    var dateOfBirth: Date
    var name: String
    var surname: String
    var position: String
    var imageName: String
    var mail: String
    var password: String
    var role: UserRole = .disposer
    
    static func == (lhs: Disponser, rhs: Disponser) -> Bool {
        (lhs.name == rhs.name) && (lhs.surname == rhs.surname) && (lhs.position == rhs.position)
    }
}

struct Admin: UserModelProtocol  {
    var id: UUID = UUID()
    var gender: Gender
    var dateOfBirth: Date
    var name: String
    var surname: String
    var position: String
    var imageName: String
    var mail: String
    var password: String
    var role: UserRole = .admin
    
    static func == (lhs: Admin, rhs: Admin) -> Bool {
        (lhs.name == rhs.name) && (lhs.surname == rhs.surname) && (lhs.position == rhs.position)
    }
}

struct Unknown: UserModelProtocol {
    var id: UUID = UUID()
    var name: String = "Неизвестно"
    var surname: String = "Неизвестно"
    var position: String = "Неизвестно"
    var imageName: String = "Empty"
    var gender: Gender = .male
    var dateOfBirth: Date = Date()
    var mail: String = "Неизвестно"
    var password: String = "Неизвестно"
    var role: UserRole = .performer
}
