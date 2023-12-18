import SwiftUI

enum AdminTabs: String, CaseIterable {
    case issues = "list.bullet.rectangle"
    case disponcers = "shared.with.you"
    case execution = "person.3"
    case settings = "gearshape"
}

struct AdminContentView: View {
    var body: some View {
        TabView {
            IssuesDisponser()
                .tabItem {
                    Label("Задачи", systemImage: AdminTabs.issues.rawValue)
                }
                
            DisponsersList()
                .tabItem {
                    Label("Руководители", systemImage: AdminTabs.disponcers.rawValue)
                }

            PerformersList()
                .tabItem {
                    Label("Исполнители", systemImage: AdminTabs.execution.rawValue)
                }

            ProfileContentView()
                .tabItem {
                    Label("Профиль", systemImage: AdminTabs.settings.rawValue)
                }
        }
        .edgesIgnoringSafeArea([.bottom,.top])
        .tint(.black)
    }
}

struct AdminContentView_Previews: PreviewProvider {
    static var previews: some View {
        AdminContentView()
    }
}
