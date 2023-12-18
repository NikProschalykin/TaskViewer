import SwiftUI

struct PerformerContentView: View {
    
    @ObservedObject var viewModel = PerformerContentViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackGround")
                    .ignoresSafeArea()
            
                VStack {
                    PerformerContentViewHeader()
                    VStack {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading) {
                                Text("Активные задачи")
                                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                    .foregroundColor(.gray)
                                    .padding([.leading,.trailing,.top], 10)
                                    .padding(.bottom,-10)
                                TaskCardsView(tasks: $viewModel.progressTasks)
                                    .padding(.all,10)
                                
                                Text("Выполненые задачи")
                                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                    .foregroundColor(.gray)
                                    .padding([.leading,.trailing,.top], 10)
                                    .padding(.bottom,-10)
                                TaskCardsView(tasks: $viewModel.completedTasks,status: .completed)
                                    .padding(.all,10)
                                
                                Text("Отмененые задачи")
                                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                    .foregroundColor(.gray)
                                    .padding([.leading,.trailing,.top], 10)
                                    .padding(.bottom,-10)
                                TaskCardsView(tasks: $viewModel.canceledTasks, status: .canceled)
                                    .padding(.all,10)
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
            .tint(.black)
        }
    }

}

struct PerformerContentView_Preview: PreviewProvider {
    static var previews: some View {
        PerformerContentView()
    }
}

struct PerformerContentViewHeader: View {
    var body: some View {
        HStack {
            Text("Задачи")
                .font(.custom(AvenirFont.bold.rawValue, size: 35))
            Spacer()
            NavigationLink {
                ProfileContentView()
            } label: {
                Image(systemName: "gear")
                    .scaleEffect(1.5)
            }
        }
        .padding(.all,20)
        .background(Color.white)
    }
}
