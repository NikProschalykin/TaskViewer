import SwiftUI

struct OverviewDisponser: View {
    /// ["1: Дизайн проекта", "2: Архитектура проекта","3: Front-часть проекта","4: Back-часть проекта"]
    @State var tasksList: [String] 
    
    var body: some View {
        ZStack {
            VStack {
                BidList(tasksList: $tasksList)
            }
            .padding()
        }
    }
}

struct OverviewDisponser_Previews: PreviewProvider {
    static var previews: some View {
        OverviewDisponser(tasksList: ["1: Дизайн проекта", "2: Архитектура проекта","3: Front-часть проекта","4: Back-часть проекта"])
    }
}

