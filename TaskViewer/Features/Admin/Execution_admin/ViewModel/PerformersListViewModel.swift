import Foundation

final class PerformersListViewModel: ObservableObject {
    
    @Published var storedPerformers: [Performer] = constatntPerformers
    
    @Published var searchText = ""
    
    var filtredPerformers: [Performer] {
        guard !searchText.isEmpty else { return storedPerformers }
        return storedPerformers.filter({ ($0.name.localizedCaseInsensitiveContains(searchText)) || ($0.surname.localizedCaseInsensitiveContains(searchText)) || ($0.position.localizedCaseInsensitiveContains(searchText))
        })
    }
    
}
