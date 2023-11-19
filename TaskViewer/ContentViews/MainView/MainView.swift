import SwiftUI

struct MainView: View {
    @State var user: UserRole = .disposer
    var body: some View {
        switch user {
        case .performer:
            Text("Performer")
        case .disposer:
            DisposerContenView()
        case .admin:
            Text("Admin")
        case .unselected:
            Text("Unselected")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

