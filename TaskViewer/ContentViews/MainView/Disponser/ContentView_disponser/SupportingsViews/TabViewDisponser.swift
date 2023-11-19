import SwiftUI

struct TabViewDisponser: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack {
            TabViewCustom(image: Tabs.overview.rawValue, selectedTab: $selectedTab)
            TabViewCustom(image: Tabs.issues.rawValue, selectedTab: $selectedTab)
            TabViewCustom(image: Tabs.execution.rawValue, selectedTab: $selectedTab)
            TabViewCustom(image: Tabs.settings.rawValue, selectedTab: $selectedTab)
        }
        .padding()
        .background(Color("ColorTab"))
        .cornerRadius(25)
        .padding(.horizontal)
    }
}

struct TabViewDisponser_Previews: PreviewProvider {
    static var previews: some View {
        TabViewDisponser(selectedTab: .constant(.issues))
            .scaledToFit()
    }
}

struct TabViewCustom: View {
    
    let image: String
    @Binding var selectedTab: Tabs
    
    var body: some View {
        GeometryReader { button in
            Button {
                withAnimation(.linear(duration: 0.3)) {
                    selectedTab = Tabs.allCases.first(where: { $0.rawValue == image }) ?? .settings
                }
            } label: {
                VStack {
                    Image(systemName: "\(image)\(selectedTab.rawValue == image ? ".fill" : "")")
                        .offset(y: selectedTab.rawValue == image ? -5 : 0)
                        .scaleEffect(selectedTab.rawValue == image ? 1.5 : 1.3)
                        .foregroundColor(selectedTab.rawValue == image ? .accentColor : .gray)
                    
                    RoundedRectangle(cornerRadius: 1)
                        .frame(width: 30, height: 2)
                        .background(selectedTab.rawValue == image ? .accentColor : Color("ColorBG"))
                        .opacity(selectedTab.rawValue == image ? 1.0 : 0.0)
                        .padding(.top, 1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}
