import Foundation
import SwiftUI
import CoreData

final class DisponcersListViewModel: ObservableObject {
    
    @Published var searchText = ""
    
    @Published var filtredDisponcers: [Disponser] = []
    
    func filterDisponcers() {
        let storedDisponcers: [Disponser] = CoreDataController.shared.fetchDisponcers()
        guard !searchText.isEmpty else { return filtredDisponcers = storedDisponcers }
        filtredDisponcers = storedDisponcers.filter({ ($0.name.localizedCaseInsensitiveContains(searchText)) || ($0.surname.localizedCaseInsensitiveContains(searchText)) || ($0.position.localizedCaseInsensitiveContains(searchText))
        })
    }
    
}
