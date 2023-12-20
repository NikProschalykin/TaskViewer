import SwiftUI

struct PerformersList: View {
    
    @StateObject private var viewModel = PerformersListViewModel()
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                NavigationLink {
                    AddUserView(user: .performer)
                } label: {
                    Label {
                        Text("Добавить")
                            .font(.custom(AvenirFont.medium.rawValue, size: 15))
                    } icon: {
                        Image(systemName: "person.fill.badge.plus")
                            .scaleEffect(1.0)
                    }
                    .tint(.green)
                }
            }
            .padding(.trailing, 20)
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
        .onAppear {
            viewModel.filterPerformers()
        }
        .searchable(text: $viewModel.searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Найти исполнителя")
    }
    
}

struct PerformersList_Previews: PreviewProvider {
    static var previews: some View {
        PerformersList()
    }
}
