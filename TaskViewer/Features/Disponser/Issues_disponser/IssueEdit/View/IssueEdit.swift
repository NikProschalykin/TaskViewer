import SwiftUI
import Foundation

struct IssueEdit: View {
    
    @StateObject var viewModel: IssueEditViewModel
    @ObservedObject var godCoordinator = GodCoordinator()
    
    @Environment(\.dismiss) var dismiss
    
    
    init(task: Task) {
        self._viewModel = StateObject(wrappedValue: IssueEditViewModel(task: task))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackGround")
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    if viewModel.isEditable {
                        VStack {
                            VStack(alignment: .leading) {
                                TitleOfBlocksView(text: "Основная информация")
                                TitleView(titleTextField: $viewModel.TitleTextField)
                                    .padding(.bottom, 5)
                                Description(descriptionTextField: $viewModel.DescriptionTextField)
                                    .padding(.bottom, 5)
                            }
                            
                            VStack(alignment: .leading) {
                                TitleOfBlocksView(text: "Шаги")
                                
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
                                
                                EditPermormersPickerView(viewModel: viewModel)
                                    .padding(.bottom, 5)
                                
                                DisponcerOfTastView()
                                    .padding(.bottom, 5)
                            }
                            
                            SaveInfoTaskButton {
                                viewModel.DescriptionSizes = viewModel.getArrayOfSizes(array: viewModel.stepsInfo)
                                viewModel.initTask = viewModel.task
                                viewModel.isEditable = false
                                viewModel.task.lastEditDate = Date()
                                viewModel.saveUpdates()
                            }
                        }
                    } else {
                        VStack {
                            VStack(alignment: .leading) {
                                if viewModel.task.status != .inProgress {
                                    HStack() {
                                        Spacer()
                                        Text(
                                            viewModel.task.status == .canceled ? "Задача отменена" : (viewModel.task.status == .completed ? "Задача выполнена" : "")
                                        
                                        )
                                            .font(.custom(AvenirFont.bold.rawValue, size: 28))
                                            .foregroundColor(viewModel.task.status == .completed ? Color.green : (viewModel.task.status == .canceled ? Color.red : Color.white))
                                        Spacer()
                                    }
                                    .padding(.all, 10)
                                }
                                HStack() {
                                    Text(viewModel.TitleTextField)
                                        .font(.custom(AvenirFont.bold.rawValue, size: 28))
                                    Spacer()
                                    if UserSettings.shared.user.role == .disposer {
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
                                                .frame(width: 30, height: 30)
                                    })
                                    }
                                }
                                .padding(.bottom,5)
                                
                                ExpandableText(text: viewModel.DescriptionTextField, lineLimit: 5, sizeOfFont: 20)
                                HStack {
                                    Spacer()
                                    if let date = viewModel.task.lastEditDate {
                                        Text(dateFormatted.string(from: date))
                                            .font(.custom(AvenirFont.regular.rawValue, size: 18))
                                    }
                                }
                                
                            }
                            .padding(.all, 10)
                            Divider()
                            VStack(alignment: .leading) {
                                Text("Шаги выполнения")
                                    .font(.custom(AvenirFont.demibold.rawValue, size: 22))
                                    .padding([.top],5)
                                    .padding([.bottom],2)
                                
                                ForEach(viewModel.stepsInfo.indices, id: \.self) { index in
                                    HStack(alignment: .top) {
                                            VStack(alignment: .leading) {
                                                if viewModel.stepsInfo[index].status == .completed {
                                                    competedCircleView(frame: 40)
                                                } else {
                                                    CircleView(number: index+1, currentStep: viewModel.task.currentStep, frame: 40)
                                                        .scaleEffect((viewModel.stepsInfo[index].status != .completed && index == viewModel.indexOfTouchedStep) ? (viewModel.startAnimationStepImage ? 2.0 : 1.0) : 1.0)
                                                }
                                                if index != viewModel.DescriptionSizes.count - 1 {
                                                    LineView(width: 2, height: viewModel.calculateHeight(height: viewModel.DescriptionSizes[index].height))
                                                        .padding(.leading, 35)
                                                }
                                            }
                                            .padding(.top,-10)
                                            VStack(alignment: .leading) {
                                                Text(viewModel.stepsInfo[index].title)
                                                    .font(.custom(AvenirFont.bold.rawValue, size: 24))
                                                
                                                ExpandableText(text: viewModel.stepsInfo[index].description, lineLimit: 5)
                                                    .background() {
                                                        GeometryReader { geometry in
                                                            Path { path in
                                                                DispatchQueue.main.async {
                                                                    viewModel.DescriptionSizes[index] = geometry.size
                                                                }
                                                            }
                                                        }
                                                    }
                                            }
                                            .padding(.top, 2)
                                            Spacer()
                                    }
                                    .gesture (
                                        LongPressGesture(minimumDuration: 0.5)
                                            .onEnded { _ in
                                                viewModel.startAnimationStepImage = false
                                                withAnimation {
                                                    if viewModel.stepsInfo[index].status != .completed {
                                                        viewModel.activeSheet = .completeStep
                                                        viewModel.showSheet = true
                                                    }
                                                }
                                        }
                                        .onChanged{ _ in
                                            withAnimation {
                                                viewModel.indexOfTouchedStep = index
                                                viewModel.startAnimationStepImage.toggle()
                                            }
                                        }
                                    )
                                    
                                }
                            }
                            Divider()
                            VStack(alignment: .leading) {
                                
                                Text("Работают над задачей")
                                    .font(.custom(AvenirFont.demibold.rawValue, size: 22))
                                    .padding([.top],5)
                                    .padding([.bottom],2)
                                
                                ForEach(viewModel.task.performers, id: \.self) { performer in
                                    HStack {
                                        NavigationLink(destination: {
                                            PerformerPreView(performer: performer)
                                        }, label: {
                                            Label(title: {
                                                Text("\(performer.name) \(performer.surname) (\(performer.position))")
                                                        .font(.custom(AvenirFont.regular.rawValue, size: 20))
                                                        .foregroundColor(Color.black)
                                            }, icon: {
                                                Image(performer.imageName)
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                            })
                                        })
                                        .disabled(UserSettings.shared.user.role == .performer)
                                        
                                        Spacer()
                                    }
                                    .padding(.bottom,1)
                                    .padding([.leading,.trailing], 10)
                                }
                            }
                            Divider()
                            VStack(alignment: .leading) {
                                
                                Text("Руководитель")
                                    .font(.custom(AvenirFont.demibold.rawValue, size: 22))
                                    .padding([.top],5)
                                    .padding([.bottom],2)
                                
                               
                                HStack {
                                    NavigationLink(destination: {
                                        DisponcerPreView(disponcer: viewModel.task.disponser)
                                    }, label: {
                                        Label(title: {
                                            Text("\(viewModel.task.disponser.name) \(viewModel.task.disponser.surname) (\(viewModel.task.disponser.position))")
                                                    .font(.custom(AvenirFont.regular.rawValue, size: 20))
                                                    .foregroundColor(Color.black)
                                        }, icon: {
                                            Image(viewModel.task.disponser.imageName)
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                        })
                                        
                                    })
                                    .disabled(UserSettings.shared.user.role == .performer)
                                    Spacer()
                                }
                                .padding(.bottom,1)
                                .padding([.leading,.trailing], 10)
                            }
                            
                            Divider()
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Дата создания:")
                                        .font(.custom(AvenirFont.demibold.rawValue, size: 22))
                                        .padding([.top],5)
                                        .padding([.bottom],2)
                                    Spacer()
                                    Text(dateFormatted.string(from: viewModel.task.creationDate))
                                        .font(.custom(AvenirFont.regular.rawValue, size: 18))
                                }
                            }
                            .padding(.all, 10)
                            
                            if (viewModel.task.status == .inProgress), (UserSettings.shared.user.role != .performer)  {
                                VStack {
                                    Divider()
                                    CustomBlueButton(buttonText: "Завершить задачу",
                                                     font: .custom(AvenirFont.medium.rawValue, size: 20),
                                                     color: .green) {
                                        viewModel.activeSheet = .completeTask
                                        viewModel.showSheet = true
                                    }

                        
                                    CustomBlueButton(buttonText: "Отменить задачу",
                                                     font: .custom(AvenirFont.medium.rawValue, size: 20),
                                                     color: .red) {
                                        viewModel.activeSheet = .cancelTask
                                        viewModel.showSheet = true
                                    }
                                }
                            }
                            
                        }
                        .padding(.all, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 0.2)
                                .background(.white)
                            
                        )
                        .cornerRadius(10.0)
                        .sheet(isPresented: $viewModel.showSheet) {
                            switch viewModel.activeSheet {
                            case .cancelTask:
                                VStack {
                                    Text("Вы уверены, что хотите отменить задачу?")
                                        .font(.custom(AvenirFont.medium.rawValue, size: 25))
                                        
                                    HStack {
                                        CustomBlueButton(buttonText: "Отменить", color: .red) {
                                            viewModel.task.status = .canceled
                                            viewModel.task.lastEditDate = Date()
                                            
                                           let description = "\(viewModel.task.disponser.name) \(viewModel.task.disponser.surname) отменил задачу \(viewModel.task.title)"
                                           viewModel.task.performers.forEach { user in
                                               godCoordinator.sendNotification(title: "Задача отменена", description: description, user: user)
                                           }
                                            viewModel.showSheet = false
                                            viewModel.saveUpdates()
                                        }
                                        
                                        CustomBlueButton(buttonText: "Продолжить выполнение", color: .blue) {
                                            viewModel.showSheet = false
                                        }
                                    }
                                }
                            case .completeTask:
                                VStack {
                                    Text("Вы уверены, что хотите завершить задачу?")
                                        .font(.custom(AvenirFont.medium.rawValue, size: 25))
                                    
                                    HStack {
                                        CustomBlueButton(buttonText: "Завершить", color: .green) {
                                            viewModel.task.status = .completed
                                            viewModel.task.lastEditDate = Date()
                                                                                
                                            let description = "\(viewModel.task.disponser.name) \(viewModel.task.disponser.surname) завершил задачу \(viewModel.task.title)"
                                            viewModel.task.performers.forEach { user in
                                                godCoordinator.sendNotification(title: "Задача завершена", description: description, user: user)
                                            }
                                            viewModel.showSheet = false
                                            viewModel.saveUpdates()
                                        }
                                        
                                        CustomBlueButton(buttonText: "Отменить", color: .red) {
                                            viewModel.showSheet = false
                                        }
                                    }
                                }
                            case .completeStep:
                                VStack {
                                    Text("Вы уверены, что хотите завершить шаг \(viewModel.indexOfTouchedStep+1)?")
                                        .font(.custom(AvenirFont.medium.rawValue, size: 25))
                                     
                                    HStack {
                                        CustomBlueButton(buttonText: "Завершить", color: .green) {
                                            viewModel.stepsInfo[viewModel.indexOfTouchedStep].status = .completed
                                            viewModel.task.lastEditDate = Date()
                                           
                                            let description = "\(UserSettings.shared.user.name) \(UserSettings.shared.user.surname) завершил шаг \(viewModel.indexOfTouchedStep+1) в задаче \(viewModel.task.title)"
                                            godCoordinator.sendNotification(title: "Шаг завершен", description: description, user: viewModel.task.disponser)
                                            
                                            viewModel.showSheet = false
                                            viewModel.stepsInfo[viewModel.indexOfTouchedStep].status = .completed
                                            viewModel.task.currentStep = (viewModel.stepsInfo.firstIndex(where: { $0.status == .inProgress }) ?? viewModel.stepsInfo.count) + 1
                                            print(viewModel.task.currentStep = (viewModel.stepsInfo.firstIndex(where: { $0.status == .inProgress }) ?? viewModel.stepsInfo.count) + 1)
                                            viewModel.saveUpdates()
                                        }
                                        
                                        CustomBlueButton(buttonText: "Отменить", color: .red) {
                                            viewModel.showSheet = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.all,10)
            }
            .navigationBarBackButtonHidden(viewModel.isEditable)
            .onTapGesture {
                hideKeyboard()
            }
            .toolbar() {
                if viewModel.task.status == .inProgress,
                   UserSettings.shared.user.role != .performer {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Изменить") {
                            viewModel.isEditable = true
                        }.opacity(viewModel.isEditable ? 0 : 1)
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            if let initTask = viewModel.initTask {
                                viewModel.task = initTask
                                viewModel.TitleTextField = initTask.title
                                viewModel.DescriptionTextField = initTask.description
                                viewModel.isConsistenly = initTask.isСonsistently
                                viewModel.stepsInfo = initTask.steps
                                
                            }
                            viewModel.DescriptionSizes = viewModel.getArrayOfSizes(array: viewModel.stepsInfo)
                            viewModel.isEditable = false
                        }, label: {
                            Text("Отменить")
                                .foregroundColor(.red)
                        }).opacity(viewModel.isEditable ? 1 : 0)
                    }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.bottom)
        .toolbar(.hidden, for: .tabBar)
        }
        
    }
}

extension String
{
   func sizeUsingFont(usingFont font: UIFont) -> CGSize
    {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}

//struct IssueEdit_Previews: PreviewProvider {
//    static var previews: some View {
//        IssueEdit(task: constantTasks.first!)
//    }
//}

struct EditPermormersPickerView: View {
    
    @ObservedObject var viewModel: IssueEditViewModel
    
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

struct SaveInfoTaskButton: View {
    
    var action: () -> Void
    var body: some View {
        CustomBlueButton(buttonText: "Сохранить изменения", action: action)
    }
}


struct ExpandableText: View {
    let text: String
    let lineLimit: Int
    var sizeOfFont: CGFloat = 16
    let fontName = AvenirFont.regular.rawValue
    
    @State private var isExpanded: Bool = false
    @State private var isTruncated: Bool? = nil
    
    init(text: String, lineLimit: Int, sizeOfFont: CGFloat = 16) {
        self.text = text
        self.lineLimit = lineLimit
        self.sizeOfFont = sizeOfFont
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(text)
                .lineLimit(isExpanded ? nil : lineLimit)
                .background(calculateTruncation(text: text))
                .font(.custom(fontName, size: sizeOfFont))
                .foregroundColor(.gray)
            
            if isTruncated == true {
                button
            }
        }
        .multilineTextAlignment(.leading)
        .onChange(of: text, perform: {
            _ in
            isTruncated = nil
        })
    }
    
    func calculateTruncation(text: String) -> some View {
        ViewThatFits(in: .vertical) {
            Text(text)
                .hidden()
                .onAppear {
                    guard isTruncated == nil else { return }
                    isTruncated = false
                }
            Color.clear
                .hidden()
                .onAppear {
                    guard isTruncated == nil else { return }
                    isTruncated = true
                }
        }
    }
    
    var button: some View {
        Button(isExpanded ? "Скрыть" : "Развернуть") {
            isExpanded.toggle()
        }
    }
}

