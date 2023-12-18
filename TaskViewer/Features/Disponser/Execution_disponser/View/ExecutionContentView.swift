import SwiftUI

struct ExecutionContentView: View {
    
    @StateObject var viewModel = ExecutionViewModel()
    
    var body: some View {
            NavigationStack {
                List {
                    if !viewModel.filtredPerformers.isEmpty {
                        ForEach(viewModel.filtredPerformers, id: \.self) { performer in
                            NavigationLink {
                                PerformerPreView(performer: performer)
                            } label: {
                                HStack {
                                    Text("\(performer.name) \(performer.surname) (\(performer.position))")
                                        .font(.custom(AvenirFont.regular.rawValue, size: 20))
                                }
                            }
                        }
                    } else {
                        Text("Ничего не найдено")
                            .font(.custom(AvenirFont.regular.rawValue, size: 20))
                    }
                }
                .navigationTitle("Исполнители")
                .listStyle(.insetGrouped)
            }
            
            .searchable(text: $viewModel.searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Найти исполнителя")
    }
}

struct ExecutionContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExecutionContentView()
    }
}
