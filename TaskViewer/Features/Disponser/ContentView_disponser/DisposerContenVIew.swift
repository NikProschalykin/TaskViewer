import SwiftUI

enum DisponserTabs: String, CaseIterable {
    case overview = "house"
    case issues = "list.bullet.rectangle"
    case execution = "person.3"
    case settings = "gearshape"
}

struct DisposerContenView: View {
    var body: some View {

        TabView {
            OverviewDisponser()
                .tabItem {
                    Label("Обзор", systemImage: DisponserTabs.overview.rawValue)
                }
                

            IssuesDisponser()
                .tabItem {
                    Label("Задачи", systemImage: DisponserTabs.issues.rawValue)
                }

            ExecutionContentView()
                .tabItem {
                    Label("Исполнители", systemImage: DisponserTabs.execution.rawValue)
                }

            ProfileContentView()
                .tabItem {
                    Label("Профиль", systemImage: DisponserTabs.settings.rawValue)
                }
        }
        .edgesIgnoringSafeArea([.bottom,.top])
        .tint(.black)

    }

}

struct DisposerContenView_Previews: PreviewProvider {
    static var previews: some View {
        DisposerContenView()
    }
}


struct TabViewDisponser: View {
    
    @Binding var selectedTab: DisponserTabs
    
    var body: some View {
        HStack {
            TabViewCustom(image: DisponserTabs.overview.rawValue, selectedTab: $selectedTab)
            TabViewCustom(image: DisponserTabs.issues.rawValue, selectedTab: $selectedTab)
            TabViewCustom(image: DisponserTabs.execution.rawValue, selectedTab: $selectedTab)
            TabViewCustom(image: DisponserTabs.settings.rawValue, selectedTab: $selectedTab)
        }
        .frame(height: 50)
        .padding(.bottom,20)
        .padding(.horizontal)
    }
}

struct TabViewCustom: View {
    let image: String
    @Binding var selectedTab: DisponserTabs
    
    var body: some View {
        GeometryReader { button in
            Button {
                withAnimation(.linear(duration: 0.3)) {
                    selectedTab = DisponserTabs.allCases.first(where: { $0.rawValue == image }) ?? .settings
                }
            } label: {
                VStack {
                    Image(systemName: "\(image)\(selectedTab.rawValue == image ? ".fill" : "")")
                        .offset(y: selectedTab.rawValue == image ? -5 : 0)
                        .scaleEffect(selectedTab.rawValue == image ? 1.3 : 1.0)
                        .foregroundColor(selectedTab.rawValue == image ? .accentColor : .gray)
                    
                    RoundedRectangle(cornerRadius: 1)
                        .background(selectedTab.rawValue == image ? .accentColor : Color("BackGround"))
                        .opacity(selectedTab.rawValue == image ? 1.0 : 0.0)
                        .padding(.top, 1)
                        .frame(width: 30, height: 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}
