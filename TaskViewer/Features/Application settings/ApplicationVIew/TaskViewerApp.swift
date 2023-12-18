import SwiftUI

@main
struct TaskViewerApp: App {
    
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
        }
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if (vm.isLoggedIn) {
            MainView()
        } else {
            LogInView()
        }
        
    }
}
