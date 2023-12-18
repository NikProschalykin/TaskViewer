import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ChangePasswordViewModel
    
    init(user: any UserModelProtocol) {
        self._viewModel = StateObject(wrappedValue: ChangePasswordViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            Color("BackGround")
                .ignoresSafeArea()
            VStack {
                Form {
                    Section("Старый пароль") {
                        HStack {
                            Text(viewModel.oldPassword)
                                .font(.custom(AvenirFont.medium.rawValue, size: 25))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        
                    }
                    
                    Section("Новый пароль") {
                        HStack {
                            if viewModel.isShowNewPassword {
                                TextField("Enter your password", text: $viewModel.newPassword)
                                    .textContentType(.password)
                                    .font(.custom(AvenirFont.medium.rawValue, size: 25))
                            } else {
                                SecureField("Enter your password", text: $viewModel.newPassword)
                                    .textContentType(.newPassword)
                                    .font(.custom(AvenirFont.medium.rawValue, size: 25))
                                    .lineLimit(1)
                            }
                            
                            Button(action: {
                                viewModel.isShowNewPassword.toggle()
                            }) {
                                Image(systemName: viewModel.isShowNewPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Section("Повторите новый пароль") {
                        HStack {
                            if viewModel.isShowReenterPassword {
                                TextField("Reenter your password", text: $viewModel.reenterPassword)
                                    .textContentType(.password)
                                    .font(.custom(AvenirFont.medium.rawValue, size: 25))
                            } else {
                                SecureField("Reenter your password", text: $viewModel.reenterPassword)
                                    .textContentType(.newPassword)
                                    .font(.custom(AvenirFont.medium.rawValue, size: 25))
                                    .lineLimit(1)
                            }
                            
                            Button(action: {
                                viewModel.isShowReenterPassword.toggle()
                            }) {
                                Image(systemName: viewModel.isShowReenterPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    
                    Section {
                        CustomBlueButton(buttonText: "Сохранить пароль", font: .custom(AvenirFont.medium.rawValue, size: 20)) {
                            viewModel.validatePassword()
                            if viewModel.passwordIsValid {
                                viewModel.saveNewPassword()
                                viewModel.showingAlert = true
                            }
                            else {
                                viewModel.showingAlert = false
                            }
                        }
                        .alert(isPresented: $viewModel.showingAlert) {
                            Alert(title: Text("Новый пароль успешно сохранен!"),dismissButton: .default(Text("Okay"), action: {dismiss()}))
                        }
                    }
                    
                    if !viewModel.passwordIsValid && !viewModel.errorMessages.isEmpty {
                        Section(header:
                                    Text("Пароль содержит ошибки")
                            .font(.custom(AvenirFont.regular.rawValue, size: 12))
                        ) {
                            ForEach(viewModel.errorMessages, id: \.self) { errorMessage in
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                .padding(.all, 10)
                Spacer()
            }
        }
        .navigationTitle("Изменение пароля")
    }
    
}
    


struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(user: constantTrackPerformers.first!)
    }
}
