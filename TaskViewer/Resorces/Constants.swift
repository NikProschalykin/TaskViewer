import Foundation

let constantAdmin: Admin = Admin(gender: .male,
                                 dateOfBirth: Date(),
                                 name: "Steve",
                                 surname: "Voznyak",
                                 position: "Admin",
                                 imageName: "Empty",
                                 mail: "admin@yahoo.com",
                                 password: "paswd")

var variableNotifications : [AppNotification] = []

let constantNotifications = [

AppNotification(title: "title 1p",
                decription: "desc 1p",
                status: .unseen,
                user: Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd")),

AppNotification(title: "title 2p",
                decription: "desc 2p",
                status: .seen,
                user: Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd")),

AppNotification(title: "title 1d",
                decription: "desc 1d",
                status: .seen,
                user: Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd")),

AppNotification(title: "title 2d",
                decription: "desc 2d",
                status: .unseen,
                user: Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd")),

AppNotification(title: "title 1a",
                decription: "desc 1a",
                status: .seen,
                user: Admin(gender: .male,
                            dateOfBirth: Date(),
                            name: "Steve",
                            surname: "Voznyak",
                            position: "Admin",
                            imageName: "Empty",
                            mail: "admin@yahoo.com",
                            password: "paswd")),

AppNotification(title: "title 2a",
                decription: "desc 2a",
                status: .unseen,
                user: Admin(gender: .male,
                            dateOfBirth: Date(),
                            name: "Steve",
                            surname: "Voznyak",
                            position: "Admin",
                            imageName: "Empty",
                            mail: "admin@yahoo.com",
                            password: "paswd")),

]

let constantCanceledTasks: [Task] = [

    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .completed),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .completed),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
         currentStep: 2,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: Date(),
         status: .canceled),
    
    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Kate", surname: "Bishop", position: "Web-teamLead", imageName: "Empty", mail: "Kate@mail.ru", password: "paswd"),
         currentStep: 1,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: nil,
         status: .canceled),

]

let constantCompletedTasks: [Task] = [

    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
         currentStep: 4,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: Date(),
         status: .completed),
    
    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Kate", surname: "Bishop", position: "Web-teamLead", imageName: "Empty", mail: "Kate@mail.ru", password: "paswd"),
         currentStep: 4,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: nil,
         status: .completed),

]

let constantTrackPerformers = [

    Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
    
]

let constantTrackTasks = [

    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
         currentStep: 2,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: Date(),
         status: .inProgress),
    
]

let constatntPerformers = [

    Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
    Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
    Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
    Performer(gender: Gender.female, dateOfBirth: Date(), name: "No", surname: "name", position: "", imageName: "Empty", mail: "NoName@mail.ru", password: "paswd"),

]

let constantDisponcers: [Disponser] = [
    
    Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
    Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Kate", surname: "Bishop", position: "Web-teamLead", imageName: "Empty", mail: "Kate@mail.ru", password: "paswd"),
    
]

let constantDisponcer: Disponser = {
    
    let disponcers =
    [
     Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
     Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Kate", surname: "Bishop", position: "Web-teamLead", imageName: "Empty", mail: "Kate@mail.ru", password: "paswd"),
    ]
    
    let random = Int.random(in: 0..<disponcers.count)
    
    return disponcers[random]
}()

let constantTasks = [

    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "1", description: "1", status: .completed),
            Step(title: "2", description: "2", status: .requestToComplete),
            Step(title: "3", description: "3", status: .inProgress),
            Step(title: "4", description: "4", status: .inProgress),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
         currentStep: 2,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: Date(),
         status: .inProgress),
    
    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Kate", surname: "Bishop", position: "Web-teamLead", imageName: "Empty", mail: "Kate@mail.ru", password: "paswd"),
         currentStep: 3,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: nil,
         status: .inProgress),
    
    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Otis", surname: "Cooper", position: "Mobile-teamLead", imageName: "Empty", mail: "Otis@mail.ru", password: "paswd"),
         currentStep: 1,
         isСonsistently: false,
         creationDate: Date(),
         lastEditDate: nil,
         status: .inProgress),
    
    Task(title: "Emprove security",
         description: "Emprove secury by adding PQC",
         steps: [
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "add pqc to tls", description: "cloudfire for tests", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
            Step(title: "Add pqc-alorythms", description: "Crystal-Kyber", status: .requestToComplete),
         ],
         performers: [
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Eric", surname: "Swift", position: "IOS-developer", imageName: "Empty", mail: "Eric@mail.ru", password: "paswd"),
            Performer(gender: Gender.female, dateOfBirth: Date(), name: "Clara", surname: "Go", position: "Backend-developer", imageName: "Empty", mail: "Clara@mail.ru", password: "paswd"),
            Performer(gender: Gender.male, dateOfBirth: Date(), name: "Mark", surname: "Javac", position: "Big Data-developer", imageName: "Empty", mail: "Javac@mail.ru", password: "paswd"),
         ],
         disponser:
            Disponser(gender: Gender.male, dateOfBirth: Date(), name: "Kate", surname: "Bishop", position: "Web-teamLead", imageName: "Empty", mail: "Kate@mail.ru", password: "paswd"),
         currentStep: 4,
         isСonsistently: true,
         creationDate: Date(),
         lastEditDate: nil,
         status: .inProgress),

]


let dateFormatted: DateFormatter = {
   let formatted = DateFormatter()
    formatted.dateFormat = "dd.MM"
    
    return formatted
}()
