import SwiftUI



struct EditUserView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditUserViewModel
    
    init(user: any UserModelProtocol) {
        self._viewModel = StateObject(wrappedValue: EditUserViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            Color("BackGround")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text(viewModel.user.role == .performer ? "Изменение исполнителя" : "Изменение руководителя")
                        .font(.custom(AvenirFont.bold.rawValue, size: 25))
                    
                    VStack(alignment: .leading) {
                        AddUserName(name: $viewModel.name, surname: $viewModel.surname, position: $viewModel.position)
                        Divider()
                        AddUserGenderBoth(gender: $viewModel.gender, birthDate: $viewModel.dateOfBirth)
                        Divider()
                        AddUserMailPassword(mail: $viewModel.mail, password: $viewModel.password)
                        CustomBlueButton(buttonText: "Сохранить изменения",
                                         font: .custom(AvenirFont.bold.rawValue, size: 20),
                                         color: .blue) {
                            viewModel.updateUser()
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

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(user: constantDisponcer)
    }
}
