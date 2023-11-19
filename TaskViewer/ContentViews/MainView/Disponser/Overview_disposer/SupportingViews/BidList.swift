import SwiftUI

struct BidList: View {
    /// ["1: Дизайн проекта", "2: Архитектура проекта","3: Front-часть проекта","4: Back-часть проекта"]
    @Binding var tasksList: [String]
    
    var body: some View {
        List {
            Section(content: {
                ForEach($tasksList.indices, id: \.self) { index in
                    Text(tasksList[index])
                }
            }, header: {
                Text("Отслеживаемые задания")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: 0))
            }
            )
            Section(content: {
                ForEach($tasksList.indices, id: \.self) { index in
                    Text(tasksList[index])
                }
                
            }, header: {
                Text("Отслеживаемые работники")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: 0))
            })
        }
        .scrollContentBackground(.hidden)
        .background(.clear)
        .environment(\.defaultMinListRowHeight, 50)
        .listStyle(.sidebar)
    }
}


//FIXME: Drop to list row
struct CustomHeader: View {
    let name: String
    let color: Color

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                Spacer()
            }
            Spacer()
        }
        .padding(0).background(FillAll(color: color))
    }
}

struct FillAll: View {
    let color: Color
    
    var body: some View {
        GeometryReader { proxy in
            self.color.frame(width: proxy.size.width * 1.3).fixedSize()
        }
    }
}
