import Foundation

final class DisponcersListViewModel: ObservableObject {
    
    @Published var storedDisponcers: [Disponser] = constantDisponcers
    
    @Published var searchText = ""
    
    var filtredDisponcers: [Disponser] {
        guard !searchText.isEmpty else { return storedDisponcers }
        return storedDisponcers.filter({ ($0.name.localizedCaseInsensitiveContains(searchText)) || ($0.surname.localizedCaseInsensitiveContains(searchText)) || ($0.position.localizedCaseInsensitiveContains(searchText))
        })
    }
}
