import SwiftUI

struct CreateIssue: View {

    @StateObject private var viewModel = CreateIssueViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("BackGround")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading) {
                        TitleOfBlocksView(text: "Основная информация")
                        
                        TitleView(titleTextField: $viewModel.TitleTextField)
                            .padding(.bottom, 5)
                        
                        Description(descriptionTextField: $viewModel.DescriptionTextField)
                            .padding(.bottom, 5)
                    }
                    
                    VStack(alignment: .leading) {
                        TitleOfBlocksView(text: "Формирование шагов")
                        
                        ConsistenlyStepsView(isConsistenly: $viewModel.isConsistenly)
                            .padding(.bottom,5)
                        
                        ForEach(viewModel.stepsInfo.indices, id: \.self) { index in
                            StepView(stepsInfo: $viewModel.stepsInfo, index: index)
                        }
                            .padding(.bottom, 5)
                        
                        AddStepButton(stepsInfo: $viewModel.stepsInfo)
                            .padding(.bottom, 5)
                    }
                    .padding(.bottom,5)
                    
                    VStack(alignment: .leading) {
                        TitleOfBlocksView(text: "Участники задачи")
                        
                        PermormersPickerView(viewModel: viewModel)
                            .padding(.bottom, 5)
                        
                        DisponcerOfTastView()
                            .padding(.bottom, 5)
                    }

                    CreateTaskButton {
                        viewModel.createTask()
                        dismiss()
                    }
                    
                }
            }
            .padding()
            .navigationBarTitle("Создание задачи")
            
        }
        .onTapGesture {
            hideKeyboard()
            
        }
    }
}

struct CreateIssue_Previews: PreviewProvider {
    static var previews: some View {
        CreateIssue()
    }
}


struct TitleView: View {
    
    @Binding var titleTextField: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Название")
                .font(Font.custom(AvenirFont.medium.rawValue, size: 24))
            issueTextField(text: $titleTextField, placeholder: "Введите название", linelimit: 1...2)
        }
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.2)
                .background(.white)
            
        )
        .cornerRadius(10.0)
    }
}

struct Description: View {
    
    @Binding var descriptionTextField: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Описание задачи")
                .font(Font.custom(AvenirFont.medium.rawValue, size: 24))
            issueTextField(text: $descriptionTextField,placeholder: "Введите описание", linelimit: 3...10)
        }
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.2)
                .background(.white)
            
        )
        .cornerRadius(10.0)
    }
}

struct StepView: View {
    
    @Binding var stepsInfo: [Step]
    var index: Int
    var currentStep = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            if stepsInfo.indices.contains(index) {
                HStack {
                    CircleView(number: index + 1, currentStep: currentStep, frame: 30)
                        .padding(.leading, -15)
                    Spacer()
                    if index != 0 {
                        Button(action: {
                            stepsInfo.remove(at: index)
                        }, label: {
                            Image("Trash")
                                .foregroundColor(.red)
                                .scaleEffect(0.8)
                            
                        })
                    }
                }
                
                Text("Название")
                    .font(Font.custom(AvenirFont.medium.rawValue, size: 20))
                issueTextField(text: $stepsInfo[index].title,placeholder: "Название шага", linelimit: 1...2)
                    .padding(.bottom)
                
                Text("Описание")
                    .font(Font.custom(AvenirFont.medium.rawValue, size: 20))
                issueTextField(text: $stepsInfo[index].description,placeholder: "Описание шага", linelimit: 3...10)
                
            }
               
        }
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.2)
                .background(.white)
            
        )
        .cornerRadius(10.0)
    }
}

struct AddStepButton: View {
    @Binding var stepsInfo: [Step]
    
    var body: some View {
        HStack(alignment: .center) {
            CustomBlueButton(buttonText: "Добавить шаг", action: {
                stepsInfo.append(Step(id: UUID(),title: "", description: "", status: .inProgress))
            })
        }
    }
}

struct PermormersPickerView: View {
    
    @ObservedObject var viewModel: CreateIssueViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Исполнители")
                    .font(Font.custom(AvenirFont.medium.rawValue, size: 20))
                
                Spacer()
                
                Menu(content: {
                    ForEach(viewModel.performersToPick, id: \.self, content: {performer in
                        Button(action: {
                            viewModel.addPickedPerformer(performer: performer)
                        }, label: {
                            Text("\(performer.name) \(performer.surname) (\(performer.position))")
                        })
                    })
                }, label: {
                    Image(systemName: "plus")
                })
            }
            
            VStack {
                ForEach(viewModel.performers, id: \.self) { performer in
                    HStack {
                        Text("\(performer.name) \(performer.surname) (\(performer.position))")
                            .font(.subheadline)
                        Spacer()
                        Button(action: {
                            viewModel.deletePickedPerformer(performer: performer)
                        }, label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .scaleEffect(0.8)
                        })
                    }.padding(.bottom,10)
                }
            }.padding(.all,5)
            
        }
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.2)
                .background(.white)
            
        )
        .cornerRadius(10.0)
    }
}

struct ConsistenlyStepsView: View {
    
    @Binding var isConsistenly: Bool
    
    var body: some View {
        HStack {
            Text("Выполнять по шагам?")
                .font(.subheadline)
            Spacer()
            Toggle("", isOn: $isConsistenly)
        }
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.2)
                .background(.white)
            
        )
        .cornerRadius(10.0)
    }
}

struct TitleOfBlocksView: View {
    
    var text: String
    var customFontName: String = AvenirFont.regular.rawValue
    var sizeOfCustomFont: CGFloat = 20
    
    var body: some View {
        Text(text)
            .font(Font.custom(customFontName, size: sizeOfCustomFont))
            .foregroundColor(.gray)
            .padding(.top,20)
            .padding(.bottom,-5)
            .padding(.leading, 10)
    }
}

struct DisponcerOfTastView: View {
    var body: some View {
        HStack() {
            Text("Назначил")
                .font(.custom(AvenirFont.regular.rawValue, size: 20))
            Spacer()
            Text("\(UserSettings.shared.user.name) \(UserSettings.shared.user.surname)")
                .font(.custom(AvenirFont.ultralight.rawValue, size: 20))
            
        }
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.2)
                .background(.white)
            
        )
        .cornerRadius(10.0)
    }
}

struct CreateTaskButton: View {
    
    var action: () -> Void
    var body: some View {
        CustomBlueButton(buttonText: "Создать задачу", action: action)
    }
}
