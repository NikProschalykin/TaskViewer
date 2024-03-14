import SwiftUI

struct DisponsersList: View {
    
    @StateObject var viewModel = DisponcersListViewModel()
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                NavigationLink {
                    AddUserView(user: .disposer)
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
                if !viewModel.filtredDisponcers.isEmpty {
                    ForEach(viewModel.filtredDisponcers, id: \.id) { disponcer in
                        NavigationLink {
                            DisponcerPreView(disponcer: disponcer)
                        } label: {
                            HStack {
                                Text("\(disponcer.name) \(disponcer.surname) (\(disponcer.position))")
                                    .font(.custom(AvenirFont.regular.rawValue, size: 20))
                            }
                        }
                    }
                } else {
                    Text("Ничего не найдено")
                        .font(.custom(AvenirFont.regular.rawValue, size: 20))
                }
            }
            .searchable(text: $viewModel.searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Найти руководителя")
            .navigationTitle("Руководители")
            .listStyle(.insetGrouped)
            
        }
        .onAppear {
            viewModel.filterDisponcers()
        }
    }
}

struct DisponsersList_Previews: PreviewProvider {
    static var previews: some View {
        DisponsersList()
    }
}
