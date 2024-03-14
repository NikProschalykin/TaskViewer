import SwiftUI

struct AddUserView: View {
    
    @StateObject private var viewModel = AddUserViewModel()
    @Environment(\.dismiss) var dismiss
    
    let role: UserRole
    
    init(user role: UserRole) {
        self.role = role
    }
    
    var body: some View {
        ZStack {
            Color("BackGround")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if role != .admin {
                        Text(role == .performer ? "Добавление исполнителя" : "Добавление руководителя")
                            .font(.custom(AvenirFont.bold.rawValue, size: 25))
                    }
                    VStack(alignment: .leading) {
                        AddUserName(name: $viewModel.name, surname: $viewModel.surname, position: $viewModel.position)
                        Divider()
                        AddUserGenderBoth(gender: $viewModel.gender, birthDate: $viewModel.dateOfBirth)
                        Divider()
                        AddUserMailPassword(mail: $viewModel.mail, password: $viewModel.password)
                        CustomBlueButton(buttonText: "Добавить",
                                         font: .custom(AvenirFont.bold.rawValue, size: 20),
                                         color: .green) {
                            viewModel.addUser(user: role)
                            dismiss()
                        }
                        .padding(.all,5)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black,lineWidth: 0.5)
                            .background(Color.white)
                                
                  }
                .padding(.all, 10)
                }
            }
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView(user: .performer)
    }
}

struct AddUserMailPassword: View {
    
    @Binding var mail: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Почта")
                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    .padding(.bottom, -2)
                issueTextField(text: $mail, placeholder: "mail@yahoo.com", linelimit: 1...2)
            }
            
            VStack(alignment: .leading) {
                Text("Пароль")
                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    .padding(.bottom, -2)
                issueTextField(text: $password, placeholder: "Password", linelimit: 1...2)
            }
        }
        .padding(.all,10)
    }
}


struct AddUserGenderBoth: View {
    
    @Binding var gender: Gender
    @Binding var birthDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("Пол")
                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                .padding(.bottom, -2)
                
                Spacer()
                
                Picker("", selection: $gender) {
                    Text("Мужской").tag(Gender.male)
                    Text("Женский").tag(Gender.female)
                }
                .pickerStyle(.menu)
                .tint(.black)
            }
            .padding(.horizontal)
            
            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                            Text("Дата рождения")
                                .font(.custom(AvenirFont.medium.rawValue, size: 20))
            }
            .padding(.horizontal)
        }
        .padding(.all, 10)
        
    }
}

struct AddUserName: View {
    
    @Binding var name: String
    @Binding var surname: String
    @Binding var position: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Имя")
                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    .padding(.bottom, -2)
                issueTextField(text: $name, placeholder: "George", linelimit: 1...2)
            }
            
            VStack(alignment: .leading) {
                Text("Фамилия")
                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    .padding(.bottom, -2)
                issueTextField(text: $surname, placeholder: "Cooper", linelimit: 1...2)
            }
            
            VStack(alignment: .leading) {
                Text("Должность")
                    .font(.custom(AvenirFont.medium.rawValue, size: 20))
                    .padding(.bottom, -2)
                issueTextField(text: $position, placeholder: "Designer", linelimit: 1...2)
            }
        }
        .padding(.all, 10)
        
    }
}
