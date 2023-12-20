import Foundation
import SwiftUI

struct PerformerPreView: View {
    
    @StateObject private var viewModel: PerformerPreViewViewModel
    
    init(performer: Performer) {
        _viewModel = StateObject(wrappedValue: PerformerPreViewViewModel(performer: performer))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackGround")
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    VStack {
                        UserPreViewHeader(user: viewModel.performer)
                            .padding([.horizontal, .vertical])
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 0.2)
                                    .background(.white)
                            )
                        .cornerRadius(30.0)
                    }
                    .padding(.all,10)
                
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text(viewModel.filtredTasks.isEmpty ? "Нет активных задач" : "Работает над задачами")
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
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                if UserSettings.shared.user is Admin {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            EditUserView(user: viewModel.performer)
                        } label: {
                            Text("Изменить")
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
                        }
                    }
                } else {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.isTrack.toggle()
                            if viewModel.isTrack {
                                viewModel.addToTrack()
                            } else {
                                viewModel.removeFromTrack()
                            }
                        }, label: {
                            Image(systemName: viewModel.isTrack ? "star.fill" : "star")
                                .resizable()
                                .foregroundColor(viewModel.isTrack ? Color.yellow : Color.black)
                                .frame(width: 25, height: 25)
                        })
                    }
                }
        }
        }
    }
}

struct UserPreViewHeader: View {
    
    let user: any UserModelProtocol
    
    var body: some View {
        HStack {
            Image(user.imageName)
                .resizable()
                .frame(width: 110, height: 110)
                .foregroundColor(.gray)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
            Spacer()
            VStack(alignment: .leading) {
                Text("ФИО: ")
                    .font(.custom(AvenirFont.regular.rawValue, size: 15))
                    .foregroundColor(.gray)
                Text("\(user.name) \(user.surname)")
                    .font(.custom(AvenirFont.bold.rawValue, size: 30))
                Text("Должность: ")
                    .font(.custom(AvenirFont.regular.rawValue, size: 15))
                    .foregroundColor(.gray)
                Text(user.position)
                    .font(.custom(AvenirFont.medium.rawValue, size: 30))
            }
            .padding(.leading, 25)
            
        }
    }
}
