import Foundation

final class ExecutionViewModel: ObservableObject {

    @Published var storedPerformers: [Performer] = CoreDataController.shared.fetchPerformers()
    
    @Published var searchText = ""
    
    var filtredPerformers: [Performer] {
        guard !searchText.isEmpty else { return storedPerformers }
        return storedPerformers.filter({ ($0.name.localizedCaseInsensitiveContains(searchText)) || ($0.surname.localizedCaseInsensitiveContains(searchText)) || ($0.position.localizedCaseInsensitiveContains(searchText))
        })
    }
    
}
