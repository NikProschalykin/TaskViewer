import SwiftUI

struct DisposerContenView: View {
    
    @State var selectedTab: Tabs = .overview
        
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    switch selectedTab {
                    case .overview :
                        OverviewDisponser(tasksList: [])
                    case .issues :
                        IssuesDisponser()
                    case .execution :
                        Text("execution")
                    case .settings :
                        Text("settings")
                    }
                    Spacer()
                    TabViewDisponser(selectedTab: $selectedTab)
                }
                .padding(.vertical)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct DisposerContenView_Previews: PreviewProvider {
    static var previews: some View {
        DisposerContenView()
    }
}

enum Tabs: String, CaseIterable {
    case overview = "house"
    case issues = "list.bullet.rectangle"
    case execution = "person.3"
    case settings = "gearshape"
}
