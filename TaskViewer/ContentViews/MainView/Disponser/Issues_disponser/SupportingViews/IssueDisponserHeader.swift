import SwiftUI

struct IssueDisponserHeader: View {
    
    var body: some View {
        HStack {
            Text("Задания")
                .font(.largeTitle)
            Spacer()
            NavigationLink {
                CreateIssue()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .scaleEffect(1.5)
            }
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 24))
    }
}

struct IssueDisponserHeader_Previews: PreviewProvider {
    static var previews: some View {
        IssueDisponserHeader()
    }
}

