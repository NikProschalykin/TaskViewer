import SwiftUI

struct ProfileContentView: View {
    
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    @StateObject private var viewModel = ProfileContentViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackGround")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    ProfileHeader(user: viewModel.user)
                    Form {
                        Section("e-mail") {
                            HStack {
                                Text(viewModel.user.mail)
                                    .font(.custom(AvenirFont.medium.rawValue, size: 30))
                                Spacer()
                            }
                        }
                        Section("Пароль") {
                            NavigationLink(destination: {
                                ChangePasswordView(user: viewModel.user)
                            }, label: {
                                Text("Изменить")
                                    .font(.custom(AvenirFont.regular.rawValue, size: 25))
                                    .foregroundColor(.blue)
                            })
                        }
                        
                        Section("Выйти из аккаунта") {
                            Button {
                                userStateViewModel.signOut()
                            } label: {
                                Text("Выйти")
                                    .font(.custom(AvenirFont.regular.rawValue, size: 25))
                                    .foregroundColor(.blue)
                            }

                        }
                    }
                }
            }
            .navigationTitle("Профиль")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.presentSheet.toggle()
                    } label: {
                        Image(systemName: "bell.circle")
                            .scaleEffect(1.5)
                    }
                }
            }
            .sheet(isPresented: $viewModel.presentSheet) {
                NotificationsList()
            }
        }
    }
}

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView()
    }
}

struct ProfileHeader: View {
    
    let user: any UserModelProtocol
    
    var body: some View {
        VStack {
            Image("Empty")
                .resizable()
                .frame(width: 150,height: 150)
                .overlay(
                    Circle()
                        .stroke(.blue, lineWidth: 4)
                )
                .padding(.all, 10)
            VStack(alignment: .leading) {
                HStack {
                    Text("\(user.name) \(user.surname)")
                        .font(.custom(AvenirFont.demibold.rawValue, size: 40))
                        .lineLimit(1...2)
                    Spacer()
                }
                Text(user.position)
                    .font(.custom(AvenirFont.medium.rawValue, size: 25))
            }
            .padding(.all, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.2)
                .background(.white)
        )
        .cornerRadius(10.0)
        .padding(.all, 10)
    }
}
