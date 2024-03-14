import SwiftUI

struct DisponcerPreView: View {
    
    @StateObject var viewModel: DisponcerPreViewViewModel
    
    init(disponcer: Disponser) {
        _viewModel = StateObject(wrappedValue: DisponcerPreViewViewModel(disponcer: disponcer))
        
    }
    
    var body: some View {
        ZStack {
            Color("BackGround")
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack {
                    UserPreViewHeader(user: viewModel.disponcer)
                        .padding([.horizontal, .vertical])
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 0.2)
                                .background(.white)
                        )
                    .cornerRadius(10.0)
                }
                .padding(.all,10)
            
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text(viewModel.filtredTasks.isEmpty ? "Нет активных задач" : "Руководит над задачами")
                            .padding([.leading], 10)
                            .padding([.bottom], -10)
                            .font(.custom(AvenirFont.regular.rawValue, size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    if !viewModel.filtredTasks.isEmpty {
                    TaskCardsView(tasks: $viewModel.filtredTasks)
                        .padding(.all,10)
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if UserSettings.shared.user is Admin {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EditUserView(user: viewModel.disponcer)
                    } label: {
                        Text("Изменить")
                            .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    }
                }
            }
        }
    }
}

//struct DisponcerPreView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisponcerPreView(disponcer: constantDisponcer)
//    }
//}
