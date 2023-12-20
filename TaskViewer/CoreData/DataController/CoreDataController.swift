import Foundation
import CoreData

final class CoreDataController {
    
    static let shared = CoreDataController()
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    public func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                print("cannot to save contex",nserror.localizedDescription)
            }
        }
    }
    
    //MARK: - CREATE
    
    // USERS
    public func createUser(user: any UserModelProtocol) {
        guard let userEntityDescription = NSEntityDescription.entity(forEntityName: "CDUser", in: self.context) else { print("Unable to create description");return }
        let CDuser = CDUser(entity: userEntityDescription, insertInto: self.context)
        
        CDuser.id = user.id
        CDuser.name = user.name
        CDuser.surname = user.surname
        CDuser.position = user.position
        CDuser.gender = user.gender.rawValue
        CDuser.birthDate = user.dateOfBirth
        CDuser.mail = user.mail
        CDuser.password = user.password
        CDuser.image = user.imageName
        CDuser.role = user.role.rawValue
        
        saveContext()
    }
    
    //STEP
    
    public func createStep(step: Step, task: CDTask) {
        guard let stepEntityDescription = NSEntityDescription.entity(forEntityName: "CDStep", in: self.context) else { print("Unable to create description");return }
        let CDstep = CDStep(entity: stepEntityDescription, insertInto: self.context)
        
        CDstep.id = step.id!
        CDstep.title = step.title
        CDstep.descriptions = step.description
        CDstep.status = step.status.rawValue
        CDstep.task = task
        saveContext()
    }
    
    //TASK
    
    public func createTask(task: Task) {
        guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: "CDTask", in: self.context) else { print("Unable to create description");return }
        let CDTask = CDTask(entity: taskEntityDescription, insertInto: self.context)
        
        CDTask.id = task.id
        CDTask.title = task.title
        CDTask.descriptions = task.description
        CDTask.currentStep = Int64(task.currentStep)
        CDTask.isConsistenly = task.isСonsistently
        CDTask.creationDate = task.creationDate
        CDTask.lastEditDate = task.lastEditDate
        CDTask.status = task.status.rawValue
        
        CDTask.disponcer = fetchUser(by: task.disponser.id)
        
        task.steps.forEach { step in
            createStep(step: step, task: CDTask)
            CDTask.addToSteps(fetchStep(by: step.id!)!)
        }
        
        task.performers.forEach { performer in
            guard let cdUser = fetchUser(by: performer.id) else { print("cannot fetch user by idlll"); return }
            cdUser.addToTask(CDTask)
            CDTask.addToPerformers(cdUser)
        }
        
        saveContext()
    }
    
    
    // TrackPerformer by Disponcer
    
    public func createTrackPerformer(disponcer: any UserModelProtocol) {
        guard let trackPerformerEntityDescription = NSEntityDescription.entity(forEntityName: "CDTrackPerformer", in: self.context) else { print("Unable to create description");return }
        let CDTrackPerformer = CDTrackPerformer(entity: trackPerformerEntityDescription, insertInto: self.context)
        
        CDTrackPerformer.disponcer = fetchUser(by: disponcer.id)
        
        saveContext()
    }
    
    //TrackTask by Disponcer
    
    public func createTrackTask(disponcer: any UserModelProtocol) {
        guard let trackTaskEntityDescription = NSEntityDescription.entity(forEntityName: "CDTrackTask", in: self.context) else { print("Unable to create description");return }
        let CDTrackTask = CDTrackTask(entity: trackTaskEntityDescription, insertInto: self.context)
        
        CDTrackTask.disponcer = fetchUser(by: disponcer.id)
        
        saveContext()
    }
    
    //Notification
    
    public func createNotification(notification: AppNotification) {
        guard let notificationEntityDescription = NSEntityDescription.entity(forEntityName: "CDNotification", in: self.context) else { print("Unable to create description");return }
        
        let CDNotification = CDNotification(entity: notificationEntityDescription, insertInto: self.context)
        
        CDNotification.id = notification.id
        CDNotification.title = notification.title
        CDNotification.descriptions = notification.decription
        CDNotification.date = notification.date
        CDNotification.status = notification.status.rawValue
        CDNotification.user = fetchUser(by: notification.user.id)
        
        saveContext()
    }
    
    //MARK: - FETCH
    
    // USERS
    public func fetchAllUsers() -> [CDUser] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            return try context.fetch(fetchRequest) as! [CDUser]
        } catch {
            print("cannot fetch all users",error.localizedDescription)
        }
        
        return []
    }
    
    //Notification
    
    public func fetchAllNotifications() -> [AppNotification] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDNotification")
        
        do {
            return (try context.fetch(fetchRequest) as! [CDNotification]).map { notificaton in
                AppNotification(id: notificaton.id!,
                                title: notificaton.title!,
                                decription: notificaton.descriptions!,
                                status: NotificationStatus(rawValue: notificaton.status!)!,
                                user: fetchUserModelProtocolUser(by: (notificaton.user?.id)!)!)
            }
        } catch {
            print("cannot fetch all notifications",error.localizedDescription)
        }
        
        return []
    }
    
    public func fetchPerformers() -> [Performer] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            let performerUsers = (try context.fetch(fetchRequest) as! [CDUser]).filter({ $0.role == UserRole.performer.rawValue })
            
            return performerUsers.map({user in
                Performer(id: user.id!,
                          gender: Gender(rawValue: user.gender!)!,
                          dateOfBirth: user.birthDate!,
                          name: user.name!,
                          surname: user.surname!,
                          position: user.position!,
                          imageName: user.image!,
                          mail: user.mail!,
                          password: user.password!,
                          role: UserRole(rawValue: user.role!)!)
            })
            
        } catch {
            print("cannot fetch Performers",error.localizedDescription)
        }
        return []
    }
    
    public func fetchDisponcers() -> [Disponser] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            let disponcerUsers = (try context.fetch(fetchRequest) as! [CDUser]).filter({ $0.role == UserRole.disposer.rawValue })
            
            return disponcerUsers.map({user in
                Disponser(id: user.id!,
                          gender: Gender(rawValue: user.gender!)!,
                          dateOfBirth: user.birthDate!,
                          name: user.name!,
                          surname: user.surname!,
                          position: user.position!,
                          imageName: user.image!,
                          mail: user.mail!,
                          password: user.password!,
                          role: UserRole(rawValue: user.role!)!)
            })
            
        } catch {
            print("cannot fetch Disponcers",error.localizedDescription)
        }
        return []
    }
    
    public func fetchAdmins() -> [Admin] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            let disponcerUsers = (try context.fetch(fetchRequest) as! [CDUser]).filter({ $0.role == UserRole.admin.rawValue })
            
            return disponcerUsers.map({user in
                Admin(id: user.id!,
                          gender: Gender(rawValue: user.gender!)!,
                          dateOfBirth: user.birthDate!,
                          name: user.name!,
                          surname: user.surname!,
                          position: user.position!,
                          imageName: user.image!,
                          mail: user.mail!,
                          password: user.password!,
                          role: UserRole(rawValue: user.role!)!)
            })
            
        } catch {
            print("cannot fetch Admins",error.localizedDescription)
        }
        return []
    }
    
    public func fetchUser(by id: UUID) -> CDUser? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            return try (context.fetch(fetchRequest) as! [CDUser]).first(where: { $0.id == id })
        } catch {
            print("cannot fetch all users",error.localizedDescription)
        }
        
        return nil
    }
    
    public func fetchUserModelProtocolUser(by id: UUID) -> (any UserModelProtocol)? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            let user = try (context.fetch(fetchRequest) as! [CDUser]).first(where: { $0.id == id })
            
            let role = UserRole(rawValue: (user?.role!)!)!
            
            switch role {
            case .performer:
                return fetchPerformers().first(where: { id == $0.id })
            case .disposer:
                return fetchDisponcers().first(where: { id == $0.id })
            case .admin:
                return fetchAdmins().first(where: { id == $0.id })
            }
            
        } catch {
            print("cannot fetch user by id",error.localizedDescription)
        }
        
        return nil
    }
    
    public func fetchUser(by mail: String, and password: String) -> CDUser? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            return try (context.fetch(fetchRequest) as! [CDUser]).first(where: { ($0.mail == mail) && ($0.password == password) })
        } catch {
            print("cannot fetch all users",error.localizedDescription)
        }
        
        return nil
    }
    
    //TASK
    
    public func fetchTask(by id: UUID) -> CDTask? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTask")
        
        do {
            return try (context.fetch(fetchRequest) as! [CDTask]).first(where: { $0.id == id })
        } catch {
            print("cannot fetch task by id",error.localizedDescription)
        }
        return nil
    }
    
    public func fetchAllTasks() -> [Task] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTask")
        
        do {
           let cdTasks = try context.fetch(fetchRequest) as! [CDTask]
            return cdTasks.map { task in
          
                let cdSteps = fetchAllTaskSteps(task: task.id!)
                
                let steps = cdSteps.map { cdstep in
                    Step(id: cdstep.id!,
                         title: cdstep.title!,
                         description: cdstep.descriptions!,
                         status: StepStatus(rawValue: cdstep.status!)!)
                }
                
                let performers = (task.performers?.allObjects as! [CDUser]).map { performer in
                    Performer(id: performer.id!,
                              gender: Gender(rawValue: performer.gender!)!,
                              dateOfBirth: performer.birthDate!,
                              name: performer.name!,
                              surname: performer.surname!,
                              position: performer.position!,
                              imageName: performer.image!,
                              mail: performer.mail!,
                              password: performer.password!,
                              role: UserRole(rawValue: performer.role!)!)
                }
                
                let disponcer = Disponser(id: (task.disponcer?.id!)!,
                                          gender: Gender(rawValue: (task.disponcer?.gender)!)!,
                                          dateOfBirth: (task.disponcer?.birthDate!)!,
                                          name: (task.disponcer?.name!)!,
                                          surname: (task.disponcer?.surname!)!,
                                          position: (task.disponcer?.position!)!,
                                          imageName: (task.disponcer?.image!)!,
                                          mail: (task.disponcer?.mail!)!,
                                          password: (task.disponcer?.password!)!,
                                          role: UserRole(rawValue: (task.disponcer?.role)!)!)
                
                return Task(id: task.id!,
                     title: task.title!,
                     description: task.descriptions!,
                     steps: steps,
                     performers: performers,
                     disponser: disponcer,
                     currentStep: Int(task.currentStep),
                     isСonsistently: task.isConsistenly,
                     creationDate: task.creationDate!,
                     lastEditDate: task.lastEditDate,
                     status: TaskStatus(rawValue: task.status!)!)
            }
            
        } catch {
            print("cannot fetch all users",error.localizedDescription)
        }
    
        return []
    }
    
    // STEP
    
    public func fetchAllSteps() -> [CDStep] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDStep")
        
        do {
            return try context.fetch(fetchRequest) as! [CDStep]
        } catch {
            print("cannot fetch step by id",error.localizedDescription)
        }
        
        return []
    }
    
    public func fetchAllTaskSteps(task id: UUID) -> [CDStep] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDStep")
        
        do {
            return try (context.fetch(fetchRequest) as! [CDStep]).filter({ $0.task?.id == id })
        } catch {
            print("cannot fetch all steps",error.localizedDescription)
        }
        return []
    }
    
    public func fetchStep(by id: UUID) -> CDStep? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDStep")
        
        do {
            return try (context.fetch(fetchRequest) as! [CDStep]).first(where: { $0.id == id })
        } catch {
            print("cannot fetch step by id",error.localizedDescription)
        }
        
        return nil
    }
    
    
    // TrackPerformer by Disponcer
    
    public func fetchTrackPerformers(to disponcer: any UserModelProtocol) -> [Performer]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTrackPerformer")
        
        do {
            let trackPerformers = try context.fetch(fetchRequest) as! [CDTrackPerformer]
            let trackPerformer = trackPerformers.first(where: { $0.disponcer?.id == disponcer.id })
            
            guard let trackPerformer else { return nil }
            let CDPerformers = trackPerformer.performer?.allObjects as! [CDUser]
            
            return CDPerformers.map { performer in
                Performer(id: performer.id!,
                          gender: Gender(rawValue: performer.gender!)!,
                          dateOfBirth: performer.birthDate!,
                          name: performer.name!,
                          surname: performer.surname!,
                          position: performer.position!,
                          imageName: performer.image!,
                          mail: performer.mail!,
                          password: performer.password!,
                          role: UserRole(rawValue: performer.role!)!)
            }
            
        } catch {
            print("cannot fetch all trackPerformers",error.localizedDescription)
            return nil
        }
        
    }
    
    //TrackTask by Disponcer
    
    public func fetchTrackTask(to disponcer: any UserModelProtocol) -> [Task]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTrackTask")
        
        do {
            let trackTasks = try context.fetch(fetchRequest) as! [CDTrackTask]
            let trackTask = trackTasks.first(where: { $0.disponcer?.id == disponcer.id })
            
            guard let trackTask else { return nil }
            let CDTasks = trackTask.task?.allObjects as! [CDTask]
        
            var filtredTasks = [Task]()
            let allDisponcerTasks = fetchAllTasks().filter({ $0.disponser.id == disponcer.id })
            CDTasks.forEach { cdTask in
                filtredTasks.append(allDisponcerTasks.first(where: { cdTask.id == $0.id })!)
            }
            
           return filtredTasks
            
        } catch {
            print("cannot fetch all trackTasks",error.localizedDescription)
            return nil
        }
        
    }
    
    //MARK: - UPDATE
    
    // USERS
    public func updateUser(for id: UUID, user: any UserModelProtocol) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            guard let users = try? context.fetch(fetchRequest) as? [CDUser],
                  let CDuser = users.first(where: { $0.id == id }) else { print("Cannot get user by id") ;return }
            CDuser.name = user.name
            CDuser.surname = user.surname
            CDuser.position = user.position
            CDuser.mail = user.mail
            CDuser.password = user.password
            CDuser.birthDate = user.dateOfBirth
            CDuser.image = user.imageName
            CDuser.gender = user.gender.rawValue
            CDuser.role = user.role.rawValue
        }
        
        saveContext()
    }
    
    //TASK
    
    public func updateTask(for id: UUID, task: Task) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTask")
        
        do {
            guard let tasks = try? context.fetch(fetchRequest) as? [CDTask],
                  let CDtask = tasks.first(where: { $0.id == id }) else { print("Cannot get task by id") ;return }
            
            CDtask.title = task.title
            CDtask.descriptions = task.description
            CDtask.currentStep = Int64(task.currentStep)
            CDtask.isConsistenly = task.isСonsistently
            CDtask.creationDate = task.creationDate
            CDtask.lastEditDate = task.lastEditDate
            CDtask.status = task.status.rawValue
            
            CDtask.disponcer = fetchUser(by: task.disponser.id)
            
            CDtask.removeFromSteps(CDtask.steps!)
            
            task.steps.forEach { step in
                deleteStep(for: step.id!)
                createStep(step: step, task: CDtask)
                CDtask.addToSteps(fetchStep(by: step.id!)!)
            }
            
            CDtask.removeFromPerformers(CDtask.performers!)
            
            task.performers.forEach { performer in
                guard let cdUser = fetchUser(by: performer.id) else { print("cannot fetch user by idlll"); return }
                cdUser.addToTask(CDtask)
                CDtask.addToPerformers(cdUser)
            }
            
        }
        saveContext()
    }
    
    //STEP
    
    public func updateStep(for id: UUID, step: Step) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDStep")
        
        do {
            guard let steps = try? context.fetch(fetchRequest) as? [CDStep],
                  let CDStep = steps.first(where: { $0.id == id }) else { print("Cannot get task by id") ;return }
            
            CDStep.title = step.title
            CDStep.descriptions = step.description
            CDStep.status = step.status.rawValue
        }
        saveContext()
    }
    
    // TrackPerformer by Disponcer
    
    public func addToTrackPerformer(to disponcer: any UserModelProtocol, of performer: any UserModelProtocol) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTrackPerformer")
        
        do {
            guard let trackedPerformers = try? context.fetch(fetchRequest) as? [CDTrackPerformer],
                  let trackedPerformer = trackedPerformers.first(where: {  trackPerformer in trackPerformer.disponcer?.id == disponcer.id}) else { print("Cannot get trackPerformer by id") ;return }
            
            trackedPerformer.addToPerformer(fetchUser(by: performer.id)!)
        }
        saveContext()
    }
    
    public func removeFromTrackPerformer(to disponcer: any UserModelProtocol, of performer: any UserModelProtocol) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTrackPerformer")
        
        do {
            guard let trackedPerformers = try? context.fetch(fetchRequest) as? [CDTrackPerformer],
                  let trackedPerformer = trackedPerformers.first(where: {  trackPerformer in trackPerformer.disponcer?.id == disponcer.id}) else { print("Cannot get trackPerformer by id") ;return }
            
            trackedPerformer.removeFromPerformer(fetchUser(by: performer.id)!)
        }
        saveContext()
    }
    
    //TrackTask by Disponcer
    
    public func addToTrackTask(to disponcer: any UserModelProtocol, task: Task) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTrackTask")
        
        do {
            guard let trackedTasks = try? context.fetch(fetchRequest) as? [CDTrackTask],
                  let trackedTask = trackedTasks.first(where: {  trackTask in trackTask.disponcer?.id == disponcer.id}) else { print("Cannot get trackTask by id") ;return }
            
            
            
            trackedTask.addToTask(fetchTask(by: task.id)!)
        }
        saveContext()
    }
    
    public func removeFromTrackTask(to disponcer: any UserModelProtocol, task: Task) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTrackTask")
        
        do {
            guard let trackedTasks = try? context.fetch(fetchRequest) as? [CDTrackTask],
                  let trackedTask = trackedTasks.first(where: {  trackTask in trackTask.disponcer?.id == disponcer.id}) else { print("Cannot get trackTask by id") ;return }
            
            trackedTask.removeFromTask(fetchTask(by: task.id)!)
        }
        saveContext()
    }
    
    //Notification
    
    public func updateNotificationStatus(for id: UUID, status: NotificationStatus) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDNotification")
        
        do {
            guard let CDNotifications = try? context.fetch(fetchRequest) as? [CDNotification],
                  let CDNotification = CDNotifications.first(where: { $0.id == id }) else { print("Cannot get trackTask by id") ;return }
            
            CDNotification.status = status.rawValue
        }
        saveContext()
    }
    
    //MARK: - DELETE
    
    // USERS
    func deleteUser(for id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDUser")
        
        do {
            guard let users = try? context.fetch(fetchRequest) as? [CDUser],
                  let CDuser = users.first(where: { $0.id == id }) else { print("Cannot get user by id") ;return }
            
            context.delete(CDuser)
        }
        
        saveContext()
    }
    
    // STEP
    
    func deleteStep(for id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDStep")
        
        do {
            guard let steps = try? context.fetch(fetchRequest) as? [CDStep],
                  let step = steps.first(where: { $0.id == id }) else { print("Cannot get step by id") ;return }
            
            context.delete(step)
        }
        
        saveContext()
    }
    
    // TrackPerformer by Disponcer
    
    public func removeTrackPerformer(disponcer: any UserModelProtocol) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTrackPerformer")
        
        do {
            guard let CDTrackPerformers = try? context.fetch(fetchRequest) as? [CDTrackPerformer],
                  let trackPerformer = CDTrackPerformers.first(where: { $0.disponcer?.id == disponcer.id }) else { print("cannot get trackPerformer by id"); return }
            
            context.delete(trackPerformer)
        }
        saveContext()
        
    }
}
