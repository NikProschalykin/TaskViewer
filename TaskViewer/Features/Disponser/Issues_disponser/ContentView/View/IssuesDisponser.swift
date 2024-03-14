import SwiftUI

struct IssuesDisponser: View {
    
    @StateObject var viewModel = IssueDisponcerViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackGround")
                    .ignoresSafeArea()
                VStack {
                    IssueDisponserHeader()
                        .padding(.bottom)
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Text("Активные задачи")
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                .foregroundColor(.gray)
                                .padding([.leading,.trailing,.top], 10)
                                .padding(.bottom,-10)
                            TaskCardsView(tasks: $viewModel.storedTasks)
                                .padding(.all,10)
                            
                            Text("Выполненые задачи")
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                .foregroundColor(.gray)
                                .padding([.leading,.trailing,.top], 10)
                                .padding(.bottom,-10)
                            TaskCardsView(tasks: $viewModel.storedTasksCompleted,status: .completed)
                                .padding(.all,10)
                            
                            Text("Отмененые задачи")
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                .foregroundColor(.gray)
                                .padding([.leading,.trailing,.top], 10)
                                .padding(.bottom,-10)
                            TaskCardsView(tasks: $viewModel.storedTasksCancelled, status: .canceled)
                                .padding(.all,10)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadTasks()
            }
        }
    }
}

struct IssueDisponserHeader: View {
    
    var body: some View {
        HStack {
            Text("Задания")
                .font(.largeTitle)
            Spacer()
            if !(UserSettings.shared.user is Admin) {
                NavigationLink {
                    CreateIssue()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .scaleEffect(1.5)
            }
            }
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 24))
    }
}
