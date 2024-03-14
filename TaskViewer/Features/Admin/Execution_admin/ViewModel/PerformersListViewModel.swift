import Foundation

final class PerformersListViewModel: ObservableObject {
    @Published var searchText = ""
    
    @Published var filtredPerformers: [Performer] = []
    
    func filterPerformers() {
        let storedPerformers: [Performer] = CoreDataController.shared.fetchPerformers()

        guard !searchText.isEmpty else { return filtredPerformers = storedPerformers }
        filtredPerformers = storedPerformers.filter({ ($0.name.localizedCaseInsensitiveContains(searchText)) || ($0.surname.localizedCaseInsensitiveContains(searchText)) || ($0.position.localizedCaseInsensitiveContains(searchText))
        })
    }
    
}
