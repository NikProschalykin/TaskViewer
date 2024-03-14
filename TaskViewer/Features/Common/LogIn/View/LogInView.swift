import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var userStateViewModel: UserStateViewModel

    @StateObject var viewModel = LogInViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("логин(mail)") {
                        TextField("Enter your login", text: $viewModel.login)
                            .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    }
                    Section("пароль") {
                        HStack {
                            if viewModel.isShowPassword {
                                TextField("Enter your password", text: $viewModel.password)
                                    .textContentType(.password)
                                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                            } else {
                                SecureField("Enter your password", text: $viewModel.password)
                                    .textContentType(.newPassword)
                                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                    .lineLimit(1)
                            }
                            
                            Button(action: {
                                viewModel.isShowPassword.toggle()
                            }) {
                                Image(systemName: viewModel.isShowPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    }
                    Section {
                        CustomBlueButton(buttonText: "Войти",font: .custom(AvenirFont.medium.rawValue, size: 20)) {
                            if viewModel.LogIn() { userStateViewModel.signIn() }
                        }
                        if viewModel.showError {
                            LabeledContent {}
                        label: {
                                Text("Неправильный логин или пароль")
                                    .font(.custom(AvenirFont.medium.rawValue, size: 15))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    Section {
                        Toggle(isOn: $viewModel.showProfiles) {
                            Text("Показать профили")
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
                        }
                    }
                    if viewModel.showProfiles {
                        Section("Существующие пользователи") {
                            HStack {
                                Button {
                                    viewModel.logInbyAdmin()
                                    userStateViewModel.signIn()
                                } label: {
                                    Text("Администратор")
                                        .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                }
                                .padding(.all,20)
                            }
                            
                            HStack {
                                Button {
                                    viewModel.logInByDisponcer()
                                    userStateViewModel.signIn()
                                } label: {
                                    Text("Руководитель")
                                        .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                }
                                .padding(.all,20)
                            }
                            HStack {
                                Button {
                                    viewModel.logInByPerformer()
                                    userStateViewModel.signIn()
                                } label: {
                                    Text("Исполнитель")
                                        .font(.custom(AvenirFont.medium.rawValue, size: 20))
                                }
                                .padding(.all,20)
                            }
                            
                            NavigationLink {
                                AddUserView(user: .admin)
                            } label: {
                                Text("Добавить админа")
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Вход в аккаунт")
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static 	var previews: some View {
        LogInView()
    }
}
