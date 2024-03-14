import SwiftUI

struct MainView: View {
    @State var user: UserRole = UserSettings.shared.user.role
    
    var body: some View {
        ZStack {
            switch user {
            case .performer:
                PerformerContentView()
            case .disposer:
                DisposerContenView()
            case .admin:
                AdminContentView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

